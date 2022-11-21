// Necessary because Dart isn't very good with dynamically typed constructors
// https://stackoverflow.com/questions/55237006/how-to-call-a-named-constructor-from-a-generic-function-in-dart-flutter
// ONLY enter those that can be returned from API endpoints



import '../domain/entites/Base_model.dart';
import '../domain/entites/auth_model.dart';

final dataFactories = {
  Null: (_) => null,
  AuthModel: (_) => AuthModel.fromJson(_),
  AuthData: (_) => AuthData.fromJson(_),
  BaseModel: (_) => BaseModel.fromJson(_),

};
