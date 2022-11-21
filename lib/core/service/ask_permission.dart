import 'package:reliable_hands/core/service/permission_handler_service.dart';

class AskPermission{

  Future<bool> askPhotoPermission() async {
    final status = await PermissionHandlerService()
        .askPermission(ReliablePermission.PHOTO);
    if (status != ReliablePermissionStatus.GRANTED) {
      return false;
    } else {
      return true;
    }
  }
}