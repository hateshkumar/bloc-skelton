abstract class ReliableBaseModel {
  /// For now keys should just be String really
  String get key => throw UnimplementedError();

  late String message;
  late int status;

  /// TODO implement all over
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
