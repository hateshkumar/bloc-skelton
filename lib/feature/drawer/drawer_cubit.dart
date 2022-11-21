import 'dart:convert';
import 'package:reliable_hands/config/export.dart';
import 'package:reliable_hands/core/util/reliable_storage.dart';
import 'package:reliable_hands/domain/entites/auth_member.dart';

class DrawerCubit extends ReliableBaseCubit {
  DrawerCubit() : super(ReliableBaseState.idle()) {
    retrieveInfo();
  }

  BehaviorSubject<AuthMember> memberSubject$ = BehaviorSubject<AuthMember>();

  Future<dynamic> retrieveInfo() async {
    emit(ReliableBaseState.primaryBusy());

    var i = await ReliableStorage.retrieveDynamicValue(ReliableStorage.userKey);

    ///Get response
    if (i != null && i != "") {
      Map<String, dynamic> response = json.decode(i.toString().trim());

      var customer = AuthMember.fromJson(response);
      memberSubject$.sink.add(customer);
    }
    emit(ReliableBaseState.idle());
  }
}
