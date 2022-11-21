import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../domain/entites/error_messages.dart';
import '../dio_extention.dart';

class GenericHTTPErrorSnackbars {
  static SnackBar customHTTPError(String code, String statusMsg, String msg) {
    return SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Only show this info in development
          if (Config().isDevelopment()) Text(code + ":" + statusMsg),
          Text(msg),
        ],
      ),
    );
  }

  static SnackBar genericHTTPError() {
    return const SnackBar(
      content: Text(ErrorMessages.GENERICHTTPERROR),
    );
  }

  static SnackBar requestTimeoutHTTPError() {
    return  const SnackBar(
      content: Text(
        ErrorMessages.REQUEST_TIMEOUT,
      ),
    );
  }

  /// This is old code to generate an http error snackbar for debugging
  /// Could probably use the newer interfaces but this will do for now
  static SnackBar? fromDioError(DioError e) {
    String errorCode = '500';
    String statusMessage = 'Internal server error';
    String message = 'Error occurred while retrieving data';
    SnackBar snackbar;
    assert(e != null);
    if (e.response?.data != null && e.response!.data is String) {
      //print("Got string error response: '${e.response?.data}'");
      if (e.response!.data.length > 0) message = e.response!.data;
    } else if (e.response?.data != null &&
        e.response!.data is Map<String, dynamic>) {
      final rawData = e.response!.data as Map<String, dynamic>;
      // print(rawData);

      final validationErrors = ValidationError.fromUnprocessableError(rawData);
      // Just grab the first one for now but there might be a few
      if (validationErrors != null && validationErrors.length > 0) {
        message = validationErrors[0].message;
      } else {
        try {
          message = rawData['msg'] ?? message;
        } catch (error) {
          // Meh
        }
      }
    } else if (e.response?.data != null) {
      // print("Got error data but couldnt parse ${e.response?.data}");
    }
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout) {
      //Nulling to make snackbar of particular type to not appear.
      return null;
    }

    if (e.type == DioErrorType.response) {
      errorCode = e.response!.statusCode.toString();
      statusMessage = e.response!.statusMessage!;
      snackbar = GenericHTTPErrorSnackbars.customHTTPError(
          errorCode, statusMessage, message);
      return snackbar;
    }

    // Catch other cases
    snackbar = GenericHTTPErrorSnackbars.genericHTTPError();
    return snackbar;
  }
}
