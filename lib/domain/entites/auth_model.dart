class AuthModel {
  AuthModel({
    String? message,
    num? status,
    AuthData? data,
  }) {
    _message = message;
    _status = status;
    _data = data;
  }

  AuthModel.fromJson(Map<dynamic, dynamic> json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? AuthData.fromJson(json['data']) : null;
  }

  String? _message;
  num? _status;
  AuthData? _data;

  AuthModel copyWith({
    String? message,
    num? status,
    AuthData? data,
  }) =>
      AuthModel(
        message: message ?? _message,
        status: status ?? _status,
        data: data ?? _data,
      );

  String? get message => _message;

  num? get status => _status;

  AuthData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class AuthData {
  AuthData({
    dynamic response,
    String? token,
  }) {
    _response = response;
    _token = token;
  }

  AuthData.fromJson(dynamic json) {
    _response = json['customer'];
    _token = json['token'];
  }

  dynamic _response;
  String? _token;

  AuthData copyWith({
    dynamic response,
    String? token,
  }) =>
      AuthData(
        response: response ?? _response,
        token: token ?? _token,
      );

  dynamic get response => _response;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer'] = _response;
    map['token'] = _token;
    return map;
  }
}
