import 'package:reliable_hands/core/api_provider.dart';

import '../../core/widgets/annotations.dart';
import '../entites/auth_model.dart';
import '../entites/customer_model.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @throws
  Future<AuthModel?> checkForceUpdate({required throwOnError}) async {
    AuthModel? status = await _apiProvider.forceUpdate(
      throwOnError: throwOnError
    );
    return status;
  }


  @throws
  Future<AuthModel?> login(String number,{required throwOnError}) async {
    AuthModel? status = await _apiProvider.login(
      number,
      throwOnError: throwOnError
    );
    return status;
  }
}
