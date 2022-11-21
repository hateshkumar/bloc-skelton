// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reliable_hands/config/export.dart';

class ReliableStorage {
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static const String tokenKey = 'tokenKey';
  static const String loginKey = 'loginkey';
  static const String userKey = 'userKey';
  static const String data = 'data';

  static dynamic storeToken(String token) async {
    await secureStorage.write(key: tokenKey, value: token);
  }

  static dynamic getToken() async {
    var result = await secureStorage.read(key: tokenKey);
    return result;
  }

  static dynamic loginStatus(String status) async {
    await secureStorage.write(key: loginKey, value: status);
  }

  static dynamic getLoginStatus() async {
    var result = await secureStorage.read(key: loginKey);
    return result;
  }

  static dynamic userDataStatus(String status) async {
    await secureStorage.write(key: data, value: status);
  }

  static dynamic getUserDataStatus() async {
    var result = await secureStorage.read(key: data);
    return result;
  }

  static dynamic storeDynamicValue(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  static dynamic retrieveDynamicValue(String key) async {
    var result = await secureStorage.read(key: key);
    return result;
  }

  static dynamic logout(BuildContext context) async {
    await secureStorage.deleteAll();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SplashView()), (Route<dynamic> route) => false);
  }
}
