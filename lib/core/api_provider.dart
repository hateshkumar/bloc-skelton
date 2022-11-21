import 'dart:io';

import 'package:reliable_hands/domain/entites/Base_model.dart';

import '../config/base_source.dart';
import '../domain/entites/auth_model.dart';

class ApiProvider extends Source {
  ApiProvider() : super(methodName: 'v1');

  Future<AuthModel> forceUpdate(
      {throwOnError = true, snackBarOnError: true}) async {
    var deviceType = Platform.isAndroid ? 'andriodAppVersion' : 'iOSAppVersion';
    var version = "1.0.0";
    final res = await get<AuthModel>(
      constructUrl('auth/forceUpdate?device_type=$deviceType&version=$version'),
      throwOnError: throwOnError,
      snackbarOnError: snackBarOnError,
    );
    return res!.data;
  }

  Future<AuthModel> login(String phone,
      {throwOnError = true, snackBarOnError = true}) async {
    final res = await get<AuthModel>(constructUrl('auth/sendOtp?phone=$phone'),
        throwOnError: throwOnError, snackbarOnError: snackBarOnError);

    return res!.data;
  }


}
