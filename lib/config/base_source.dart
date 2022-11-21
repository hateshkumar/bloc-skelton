import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reliable_hands/config/parser.dart';
import 'package:reliable_hands/core/dio_extention.dart';

import '../core/blocs/state_blocs/global_bloc.dart';
import '../core/dio_retry.dart';
import '../core/navigator/navigator_helper.dart';
import '../core/pagination.dart';
import '../core/service/error_service.dart';
import '../core/util/reliable_storage.dart';
import '../core/widgets/dialog/reliable_dialog.dart';
import '../core/widgets/dialog/reliable_error_dialogs.dart';
import '../core/widgets/generic_http_error_snackbars.dart';
import '../domain/entites/api_response_model.dart';
import '../domain/entites/reliable_enum.dart';
import 'config.dart';

/// If we introduce a new version of the API, we need to make that source a part of this file else we wont be able to access the private base methods listed here;
part 'source.dart';

class ReliableDioOption<String> extends ReliableEnum<String> {
  const ReliableDioOption(String value) : super(value);

  static const SnackbarOnError = ReliableDioOption('snackbarOnError');
  static const AuthorizationOAuth = ReliableDioOption('oAuth');
}

abstract class BaseSource {
  static _parseAndDecode(String responseBody) {
    return json.decode(responseBody);
  }

  static parseJson(String responseBody) {
    return compute(_parseAndDecode, responseBody);
  }

  final Dio dio = Dio();

  //Can add this transformer to the dio instance to make it work with the isolate transformer
  // ..transformer = DefaultTransformer(jsonDecodeCallback: parseJson);

  final String apiUrl;
  final String methodName;
  final Parser parser;

  final ignoreResponseStatusCodes = [304];

  /// Whether to include oauth token in every request
  final bool useAuthentication = true;

  BaseSource({
    required this.apiUrl,
    required this.methodName,
    required this.parser,
  }) {
    _setupInterceptors();
  }

  Options makeOptions(Options options) {
    assert(options.headers == null,
        "We'll need a proper deep copy if you want to set headers");

    return options.copyWith(
      headers: {
        // This allows the server to send gzipped JSON which is a lot smaller
        // Testing shows the trade-off between CPU and bandwidth looks worth it
      },
    );
  }

  //Problem with this is that we need to know the type of the response, so we can parse it accordingly
  //For this case where T is the simple type like Meetup or MeetupWrapper we can do that easily
  //But when T is somethin like APIResponse<T> we need to know the type of T which we cant and then this is the problem
  //so it's better not to parse this in the most inner layer and do it in the outer layer where we know the type
  //TODO: Find a better way to do this
  Future<Response?> _get(
    String url, {
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = true,
    bool throwOnError = false,
    bool retry = true,
  }) async {
    try {
      final Response res = await dio.get(
        url,
        options: makeOptions(Options(
          extra: {
            ReliableDioOption.SnackbarOnError.value: snackbarOnError,
            if (!retry) ...RetryOptions.noRetry().toExtra(),
            ...dioExtraOptions,
          },
        )),
      );

      if (res.statusCode != 200) {
        ErrorService().error.sink.add(res);
      }
      return res;
    } catch (e) {
      showTimeoutDialog();
      if (throwOnError) rethrow;
    }
    return null;
  }

  Future<Response?> _post(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    try {
      Response res = await dio.post(
        url,
        data: body,
        options: makeOptions(Options(
          extra: {
            ReliableDioOption.SnackbarOnError.value: snackbarOnError,
            if (!retry) ...RetryOptions.noRetry().toExtra(),
            ...dioExtraOptions,
          },
        )),
      );
      return res;
    } catch (e) {
      showTimeoutDialog();
      if (throwOnError) rethrow;
    }
    return null;
  }

  Future<Response?> _put(
    String url, {
    required Map<String, dynamic> body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    try {
      Response res = await dio.put(
        url,
        data: body,
        options: makeOptions(Options(
          extra: {
            ReliableDioOption.SnackbarOnError.value: snackbarOnError,
            if (!retry) ...RetryOptions.noRetry().toExtra(),
            ...dioExtraOptions,
          },
        )),
      );
      return res;
    } catch (e) {
      if (throwOnError) rethrow;
    }
    return null;
  }

  Future<Response?> _delete(
    String url, {
    Map<String, dynamic>? body,
    Map<String, dynamic> dioExtraOptions = const {},
    bool snackbarOnError = false,
    bool throwOnError = true,
    bool retry = false,
  }) async {
    try {
      Response res = await dio.delete(
        url,
        data: body,
        options: makeOptions(Options(
          extra: {
            ReliableDioOption.SnackbarOnError.value: snackbarOnError,
            if (!retry) ...RetryOptions.noRetry().toExtra(),
            ...dioExtraOptions,
          },
        )),
      );
      return res;
    } catch (e) {
      if (throwOnError) rethrow;
    }
    return null;
  }

  String constructUrlWithoutMethodName(String path) => '$apiUrl/$path';

  String constructUrl(String path) => '$apiUrl/$methodName/$path';

  String constructQueryUrl(String path, Map<String, String?> query) =>
      '$apiUrl/$methodName/$path?${query.entries.where((kv) => kv.value != null).map((kv) => '${kv.key}=${kv.value}').join('&')}';

  String constructQueryPageUrl(
          String path, Map<String, String> query, PageRequest page) =>
      constructQueryUrl(
        path,
        {
          ...query,
          page.constructSortKey(): page.lastValue,
          'limit': '${page.limit}'
        },
      );

  String constructPageUrl(String path, PageRequest page) => constructQueryUrl(
        path,
        {
          'limit': '${page.limit}',
          // Eg '&createdAt:lte=...'
          page.constructSortKey(): page.lastValue
        },
      );

  _setupInterceptors() {
    // Custom error handling
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          options.extra.putIfAbsent(
            ReliableDioOption.AuthorizationOAuth.value,
            () => false,
          );
          if (options.extra
                  .containsKey(ReliableDioOption.AuthorizationOAuth.value) &&
              !options.extra[ReliableDioOption.AuthorizationOAuth.value] &&
              useAuthentication) {
            try {
              final accessToken = await ReliableStorage.getToken();

              options.headers['token'] = accessToken;
            } catch (e) {
              // TODO need to find a better way to deal with failing to get access token
              // The problem is that the error didn't seem to propagate outside of Dio... this might be new behavior
              options.headers['token'] = '';
            }
          }
          if (Config().isDevelopment()) {
            options.connectTimeout = 15000;
            options.receiveTimeout = 15000;
          } else {
            options.connectTimeout = 30000;
            options.receiveTimeout = 30000;
          }
          options.extra.putIfAbsent(
            ReliableDioOption.SnackbarOnError.value,
            () => true,
          );
          return handler.next(options);
        },
        onResponse: (Response response, handler) async {
          return handler.next(response);
        },
        onError: (DioError e, handler) async {
          if (e.requestOptions.extra
                  .containsKey(ReliableDioOption.SnackbarOnError.value) &&
              !e.requestOptions.extra[ReliableDioOption.SnackbarOnError.value]) {
            // Log().debug('Sshh no snacky bar today');
            return handler.next(e);
          }

          ///Check if the error is 304 then we are good to go as our ETag caching works we just serve the cached version
          if (e.response != null &&
              ignoreResponseStatusCodes.contains(e.response!.statusCode)) {
            return handler.next(e);
          }
          // Why doesn't this throw??
          final errorSnackbar = GenericHTTPErrorSnackbars.fromDioError(e);
          // Snackbars only work in Scaffold
          // Login sequence is not scaffold
          // Login sequence is wrapped in Scaffold cause of builder. If it still not shows it must be something else

          if (e.isConnectionError()) {
            globalBloc.showConnectionErrorSnackBar();
            return handler.next(e);
          }

          if (globalBloc.scaffoldKey.currentContext != null &&
              errorSnackbar != null) {
            // NOTE can't hide+show because if this is called many times it will just
            // go up/down really quickly
            // Instead we just throttle so only one error shows in case of multiple
            final statusCodeRegex = RegExp(r'^5\d{2}$'); // regex for 5XX

            /// If the environment is production and the error status code is not in 5XX
            /// we will show the Snack-bar
            if (Config().isProduction() &&
                e.response != null &&
                !statusCodeRegex.hasMatch(e.response!.statusCode.toString()))
              globalBloc.showHttpErrorSnackBar(errorSnackbar);

            /// If the environment is development or QA show the Snack-bar
            /// without checking the error status code
            else if (Config().isDevelopment() || Config().isQA())
              globalBloc.showHttpErrorSnackBar(errorSnackbar);

            return handler.next(e);
          }
        },
      ),
    );

    // Retry logic
    dio.interceptors.add(
      RetryInterceptor(
        dio: this.dio,
        options: RetryOptions(
          retries: 2,
          retryInterval: const Duration(milliseconds: 500),
          retryEvaluator: (error) {
            // Firebase will have info, we don't need to retry
            // TODO there's actually one firebase error of type connection error, figure out how to catch
            //if (error.firebaseException != null) return false;

            // TODO look at different errors where the type is DioErrorType.other and see which ones we want to retry
            bool shouldRetry = false;
            // GETs are super retry-able, POST/PUT/PATCH/DELETE are less so
            if (error.requestOptions.method == 'GET' &&
                error.type != DioErrorType.cancel &&
                error.type != DioErrorType.response)
              shouldRetry = true;
            // TODO need to check if connectTimeouts are not dangerous
            else if (error.type == DioErrorType.sendTimeout ||
                error.type == DioErrorType.connectTimeout) shouldRetry = true;

            print(
                "Retry? $shouldRetry -> ${error.message} (${error.requestOptions.method} ${error.requestOptions.path})");
            return shouldRetry;
          },
        ),
        // TODO logger
        // logger: Logger("Retry")
      ),
    );
  }

  showTimeoutDialog() {
    GenericTimeoutDialog(
      actions: [
        ReliableDialogButton(
          label: "RETRY",
          dialogButtonType: DialogButtonTypes.SECONDARY,
          onPressed: () {
            NavigatorHelper().pop();
            retry();
          },
        ),
      ],
    ).show(dismissible: false);
  }

  retry() async {
    await NavigatorHelper().navigateToScreen('/splash');
  }
}
