
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';


class ErrorService {
  static final ErrorService _instance =
  ErrorService._internal();

  ErrorService._internal();

  factory ErrorService() {
    return _instance;
  }


  final BehaviorSubject<Response<dynamic>> error =
  BehaviorSubject();

  reset() {
    error.drain(null);
  }

  goBack() {
    reset();
  }
}
