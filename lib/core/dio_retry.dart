// Grabbed from unmaintained https://github.com/aloisdeniel/dio_retry

import 'dart:async';

import 'package:dio/dio.dart';

typedef FutureOr<bool> RetryEvaluator(DioError error);

class RetryOptions {
  /// The number of retry in case of an error
  final int retries;

  /// The interval before a retry.
  final Duration retryInterval;

  /// Evaluating if a retry is necessary.regarding the error.
  ///
  /// It can be a good candidate for additional operations too, like
  /// updating authentication token in case of a unauthorized error (be careful
  /// with concurrency though).
  ///
  /// Defaults to [defaultRetryEvaluator].
  RetryEvaluator get retryEvaluator =>
      this._retryEvaluator ?? defaultRetryEvaluator;

  final RetryEvaluator? _retryEvaluator;

  const RetryOptions(
      {this.retries = 3,
      RetryEvaluator? retryEvaluator,
      this.retryInterval = const Duration(seconds: 1)})
      : assert(retries != null),
        assert(retryInterval != null),
        this._retryEvaluator = retryEvaluator;

  factory RetryOptions.noRetry() => const RetryOptions(retries: 0);

  static const extraKey = "cache_retry_request";

  /// Returns [true] only if the response hasn't been cancelled or got
  /// a bas status code.
  static FutureOr<bool> defaultRetryEvaluator(DioError error) {
    return error.type != DioErrorType.cancel &&
        error.type != DioErrorType.response;
  }

  factory RetryOptions.fromExtra(
      RequestOptions request, RetryOptions alternate) {
    return request.extra[extraKey] ?? alternate;
  }

  RetryOptions copyWith({
    int? retries,
    Duration? retryInterval,
  }) =>
      RetryOptions(
        retries: retries ?? this.retries,
        retryInterval: retryInterval ?? this.retryInterval,
      );

  Map<String, dynamic> toExtra() {
    return {
      extraKey: this,
    };
  }

  Options toOptions() {
    return Options(extra: this.toExtra());
  }

  Options mergeIn(Options options) {
    return options.copyWith(
      extra: <String, dynamic>{}
        ..addAll(options.extra ?? {})
        ..addAll(this.toExtra()),
    );
  }
}

/// An interceptor that will try to send failed request again
class RetryInterceptor extends Interceptor {
  final Dio dio;

  final RetryOptions options;

  RetryInterceptor({required this.dio, RetryOptions? options})
      : this.options = options ?? const RetryOptions();

  @override
  onError(DioError err, handler) async {
    var extra = RetryOptions.fromExtra(err.requestOptions, this.options);

    var shouldRetry = extra.retries > 0 && await extra.retryEvaluator(err);
    if (shouldRetry) {
      if (extra.retryInterval.inMilliseconds > 0) {
        await Future.delayed(extra.retryInterval);
      }

      // Update options to decrease retry count before new try
      extra = extra.copyWith(retries: extra.retries - 1);
      err.requestOptions.extra = err.requestOptions.extra
        ..addAll(extra.toExtra());

      try {
        // We retry with the updated options
        final Response response = await this.dio.request(
              err.requestOptions.path,
              cancelToken: err.requestOptions.cancelToken,
              data: err.requestOptions.data,
              onReceiveProgress: err.requestOptions.onReceiveProgress,
              onSendProgress: err.requestOptions.onSendProgress,
              queryParameters: err.requestOptions.queryParameters,
              // TODO do this better?? Very un-future-proof
              options: Options(
                method: err.requestOptions.method,
                sendTimeout: err.requestOptions.sendTimeout,
                receiveTimeout: err.requestOptions.receiveTimeout,
                extra: err.requestOptions.extra,
                headers: err.requestOptions.headers,
                responseType: err.requestOptions.responseType,
                contentType: err.requestOptions.contentType,
                validateStatus: err.requestOptions.validateStatus,
                receiveDataWhenStatusError:
                    err.requestOptions.receiveDataWhenStatusError,
                followRedirects: err.requestOptions.followRedirects,
                maxRedirects: err.requestOptions.maxRedirects,
                requestEncoder: err.requestOptions.requestEncoder,
                responseDecoder: err.requestOptions.responseDecoder,
                listFormat: err.requestOptions.listFormat,
              ),
            );
        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.next(e);
      }
    }

    return handler.next(err);
  }
}
