class BaseModel{
  BaseModel({
      this.message, 
      this.status, 
   });

  BaseModel.fromJson(dynamic json) {
    print("***** ${json.toString()}");
    message = json['message'];
    status = json['status'];
  }
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    return map;
  }


}
