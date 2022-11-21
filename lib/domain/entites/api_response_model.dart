import 'package:reliable_hands/domain/entites/reliable_base_model.dart';

import '../../config/index.dart';

class ApiResponse<T> extends ReliableBaseModel {
  T data;
  String message;
  int status;

  ApiResponse._(
      {required this.data, required this.message, required this.status});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    assert(dataFactories.containsKey(T),
        'Type not found in dataFactories ${T.toString()}');
    T model = dataFactories[T]!(json) as T;

    return ApiResponse._(
        data: model, message: json['message'], status: json['status']);
  }
}
