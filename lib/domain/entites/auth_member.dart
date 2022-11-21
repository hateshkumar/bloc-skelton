class AuthMember {
  String? id;
  String? name;
  String? email;
  String? description;
  String? otp;
  String? emailVerifiedAt;
  String? otpVerifiedAt;
  String? photo;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? source;
  String? active;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? country;

  AuthMember({
    this.id,
    this.name,
    this.email,
    this.description,
    this.otp,
    this.emailVerifiedAt,
    this.otpVerifiedAt,
    this.photo,
    this.phone,
    this.source,
    this.gender,
    this.dateOfBirth,
    this.active,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.country,
  });

  AuthMember.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    description = json['description']?.toString();
    otp = json['otp']?.toString();
    emailVerifiedAt = json['email_verified_at']?.toString();
    otpVerifiedAt = json['otp_verified_at']?.toString();
    photo = json['photo']?.toString();
    phone = json['phone']?.toString();
    source = json['source']?.toString();
    gender = json['gender']?.toString();
    dateOfBirth = json['date_of_birth']?.toString();
    active = json['active']?.toString();
    rememberToken = json['remember_token']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
    country = json['country']?.toString() ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['description'] = description;
    data['otp'] = otp;
    data['email_verified_at'] = emailVerifiedAt;
    data['otp_verified_at'] = otpVerifiedAt;
    data['photo'] = photo;
    data['phone'] = phone;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['active'] = active;
    data['source'] = source;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['country'] = country;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Initial data $name $email $photo $phone $gender $createdAt";
  }
}
