import 'dart:io';

import 'package:dio/dio.dart';

abstract class ReliableHttpError {
  final int code;
  final String message;

  ReliableHttpError({
    required this.code,
    required this.message,
  });

  static const BAD_REQUEST = 400;
  static const UNAUTHENTICATED = 401;
  static const UNAUTHORIZED = 403;
  static const NOT_FOUND = 404;
  static const CONFLICT = 409;
  static const UNPROCESSABLE = 422;
  static const SERVER = 500;

  // TODO implement the whole lot
  factory ReliableHttpError.fromDioError(DioError e) {
    // Connection errors are not HTTP errors, need to be handled somewhere else
    assert(e.isHttpError());
    if (e.isBadRequestError()) return BadRequestError.fromDioError(e);
    if (e.isNotFoundError()) throw UnimplementedError();
    if (e.isConflictError()) return ConflictError.fromDioError(e);
    if (e.isValidationError()) throw UnimplementedError();
    if (e.isUnauthenticatedError()) throw UnimplementedError();
    if (e.isUnauthorizedError()) throw UnimplementedError();
    if (e.isServerError()) throw UnimplementedError();
    throw UnsupportedError("Unknown HTTP Error $e");
  }

  static const List<String> _serverDefaultMsgs = [
    'Bad Request',
    'Unauthenticated',
    'Unauthorized',
    'Resource not found',
    'Conflict',
    'Validation failed',
    'Something unexpected happened',
  ];

  /// Since message is non nullable by server,
  /// So default messages are considered as no message
  bool hasMessage() {
    return !(message == null ||
        message.isEmpty ||
        _serverDefaultMsgs.contains(message));
  }
}

// TODO add defaults for non-nullable properties and ? to nullable
class ValidationError {
  final String message;
  final String type;
  final String path;
  final String value;

  ValidationError.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        type = json['type'],
        value = json['value'].toString(),
        path = json['path'];

  static List<ValidationError>? fromUnprocessableError(
      Map<String, dynamic> json) {
    if (!json.containsKey('errors')) return null;
    final rawErrors = json['errors'] as List<dynamic>;
    return rawErrors
        .map((json) => ValidationError.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // TODO change this so it's no longer a list but instead it contains a list
  // That way we can return it from ReliableHttpError.fromDioError
  static List<ValidationError>? fromDioError(DioError e) {
    if (e.response?.data == null) return null;
    if (e.isValidationError())
      return fromUnprocessableError(e.response?.data as Map<String, dynamic>);
    return [];
  }
}

// TODO add defaults for non-nullable properties and ? to nullable
class ConflictError extends ReliableHttpError {
  final dynamic error;

  ConflictError.fromJson(Map<String, dynamic> json)
      : error = json.containsKey('error') ? json['error'] : null,
        super(code: 409, message: json['msg']);

  // I tried to make this a redirecting constructor but doesn't work with asserts because
  ConflictError.fromDioError(DioError e)
      : assert(e.isConflictError()),
        assert(e.response?.data != null),
        error = e.response?.data['error'] as dynamic,
        super(code: 409, message: e.response?.data['msg']);

  /// Return the first existing key.
  String? getConflictField() {
    if (!(error is Map<String, dynamic>)) return null;
    final _error = error as Map<String, dynamic>;
    if (_error.isEmpty) return null;
    return _error.keys.first;
  }

  /// Check if [field] is causing the conflict
  bool isConflictField(String field) {
    return getConflictField() == field;
  }
}

// TODO add defaults for non-nullable properties and ? to nullable
class BadRequestError extends ReliableHttpError {
  final dynamic error;

  BadRequestError.fromJson(Map<String, dynamic> json)
      : error = json.containsKey('error') ? json['error'] : null,
        super(code: 400, message: json['msg'] as String);

  // I tried to make this a redirecting constructor but doesn't work with asserts because
  BadRequestError.fromDioError(DioError e)
      : assert(e.isBadRequestError()),
        assert(e.response?.data != null),
        error = e.response?.data['error'] as dynamic,
        super(code: 400, message: e.response?.data['msg'] as String);
}

extension ErrorHandling on DioError {
  /// [false] for connection errors etc
  /// [true] for anything with a status code -- proper HTTP API errors
  bool isHttpError() {
    // return this.response.statusCode != null;
    return this.type == DioErrorType.response;
  }

  bool isBadRequestError() =>
      response?.statusCode == ReliableHttpError.BAD_REQUEST;

  bool isConflictError() => response?.statusCode == ReliableHttpError.CONFLICT;

  bool isValidationError() =>
      response?.statusCode == ReliableHttpError.UNPROCESSABLE;

  bool isNotFoundError() => response?.statusCode == ReliableHttpError.NOT_FOUND;

  bool isUnauthenticatedError() =>
      response?.statusCode == ReliableHttpError.UNAUTHENTICATED;

  bool isUnauthorizedError() =>
      response?.statusCode == ReliableHttpError.UNAUTHORIZED;

  bool isServerError() => response?.statusCode == ReliableHttpError.SERVER;

  bool isConnectionError() {
    if (type == DioErrorType.other &&
        response == null &&
        error == null) {
      return true;
    }
    // Triggers for connection refused
    if (type == DioErrorType.other && this.error is SocketException) {
      return true;
    }
    return [
      DioErrorType.sendTimeout,
      DioErrorType.receiveTimeout,
      DioErrorType.connectTimeout,

      // Can happen when connection is off, DNS errors
      // Note we're assuming it's a connection error, it's probably true
      // Still, might want to behave differently in some cases if connection is off
      // A list so far:
      // - HttpException, uri = ..
      // - SocketException: OS Error: Connection refused
      // - HandshakeException: Connection terminated during handshake
      DioErrorType.other,
    ].contains(this.type);
  }

  bool isRequestSent() {
    return ![
      DioErrorType.other,
      DioErrorType.connectTimeout,
      DioErrorType.sendTimeout
    ].contains(this.type);
  }
}
