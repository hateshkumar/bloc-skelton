class CustomerModel {
  CustomerModel({
      String? message, 
      num? status, 
      Data? data,}){
    _message = message;
    _status = status;
    _data = data;
}

  CustomerModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  num? _status;
  Data? _data;
CustomerModel copyWith({  String? message,
  num? status,
  Data? data,
}) => CustomerModel(  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get message => _message;
  num? get status => _status;
  Data? get data => _data;

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

class Data {
  Data({
      Customer? customer, 
      String? token,}){
    _customer = customer;
    _token = token;
}

  Data.fromJson(dynamic json) {
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    _token = json['token'];
  }
  Customer? _customer;
  String? _token;
Data copyWith({  Customer? customer,
  String? token,
}) => Data(  customer: customer ?? _customer,
  token: token ?? _token,
);
  Customer? get customer => _customer;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_customer != null) {
      map['customer'] = _customer?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

class Customer {
  Customer({
      num? id, 
      String? name, 
      String? email, 
      String? otp, 
      dynamic emailVerifiedAt, 
      dynamic otpVerifiedAt, 
      String? address, 
      String? photo, 
      String? phone, 
      dynamic gender, 
      dynamic dateOfBirth, 
      String? source, 
      dynamic rememberToken, 
      num? active, 
      dynamic deletedAt, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _email = email;
    _otp = otp;
    _emailVerifiedAt = emailVerifiedAt;
    _otpVerifiedAt = otpVerifiedAt;
    _address = address;
    _photo = photo;
    _phone = phone;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _source = source;
    _rememberToken = rememberToken;
    _active = active;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Customer.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _otp = json['otp'];
    _emailVerifiedAt = json['email_verified_at'];
    _otpVerifiedAt = json['otp_verified_at'];
    _address = json['address'];
    _photo = json['photo'];
    _phone = json['phone'];
    _gender = json['gender'];
    _dateOfBirth = json['date_of_birth'];
    _source = json['source'];
    _rememberToken = json['remember_token'];
    _active = json['active'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _email;
  String? _otp;
  dynamic _emailVerifiedAt;
  dynamic _otpVerifiedAt;
  String? _address;
  String? _photo;
  String? _phone;
  dynamic _gender;
  dynamic _dateOfBirth;
  String? _source;
  dynamic _rememberToken;
  num? _active;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;
Customer copyWith({  num? id,
  String? name,
  String? email,
  String? otp,
  dynamic emailVerifiedAt,
  dynamic otpVerifiedAt,
  String? address,
  String? photo,
  String? phone,
  dynamic gender,
  dynamic dateOfBirth,
  String? source,
  dynamic rememberToken,
  num? active,
  dynamic deletedAt,
  String? createdAt,
  String? updatedAt,
}) => Customer(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  otp: otp ?? _otp,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  otpVerifiedAt: otpVerifiedAt ?? _otpVerifiedAt,
  address: address ?? _address,
  photo: photo ?? _photo,
  phone: phone ?? _phone,
  gender: gender ?? _gender,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  source: source ?? _source,
  rememberToken: rememberToken ?? _rememberToken,
  active: active ?? _active,
  deletedAt: deletedAt ?? _deletedAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get otp => _otp;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get otpVerifiedAt => _otpVerifiedAt;
  String? get address => _address;
  String? get photo => _photo;
  String? get phone => _phone;
  dynamic get gender => _gender;
  dynamic get dateOfBirth => _dateOfBirth;
  String? get source => _source;
  dynamic get rememberToken => _rememberToken;
  num? get active => _active;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['otp'] = _otp;
    map['email_verified_at'] = _emailVerifiedAt;
    map['otp_verified_at'] = _otpVerifiedAt;
    map['address'] = _address;
    map['photo'] = _photo;
    map['phone'] = _phone;
    map['gender'] = _gender;
    map['date_of_birth'] = _dateOfBirth;
    map['source'] = _source;
    map['remember_token'] = _rememberToken;
    map['active'] = _active;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}