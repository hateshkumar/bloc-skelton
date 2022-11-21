import 'package:dio/dio.dart';
import 'package:reliable_hands/config/export.dart';
import 'package:reliable_hands/core/dio_extention.dart';
import 'package:reliable_hands/domain/entites/auth_model.dart';
import 'package:reliable_hands/feature/forceUpdate/force_update.dart';

import '../../core/util/errors.dart';
import '../../core/util/reliable_storage.dart';
import '../../core/widgets/dialog/reliable_dialog.dart';
import '../../core/widgets/dialog/reliable_error_dialogs.dart';

class AuthCubit extends ReliableBaseCubit {
  AuthCubit() : super(ReliableBaseState.initializing()) {
//    init();
  }

  init() async {
    await startup();
  }

  Future<void> startup() async {
    emit(ReliableBaseState.secondaryBusy());

    try {
      final forceUpdate = await splashRepo.checkForceUpdate(throwOnError: true);
      await onSuccess(forceUpdate);
      globalBloc.initializeGlobalState();
    } catch (error, stack) {
      await onError(error, stack);
    }
    emit(ReliableBaseState.idle());
  }

  Future<void> onSuccess(AuthModel? forceUpdate) async {
    if (forceUpdate!.status == 200) {
      String status = await ReliableStorage.getLoginStatus() ?? "0";
      String dataStatus = await ReliableStorage.getUserDataStatus() ?? "0";
      if (status == '0') {
//        NavigatorHelper().navigateAnClearAll(LoginView.route);
      } else {
        NavigatorHelper().navigateAnClearAll(MainHomeView.route);
      }
    } else if (forceUpdate.status == 404) {
      Map data = {
        'message': forceUpdate.message,
        'code': forceUpdate.status,
      };

      NavigatorHelper()
          .navigateAnClearAll(ForceUpdate.route, arguments: {'data': data});
    } else {
      globalBloc.showSnackBar(message: forceUpdate.message);
    }
  }

  @override
  Future<void> onError(error, stack) async {
    print('On startup error  $error, $stack');

    if (error is DioError && (error.isConnectionError())) {
      return await showTimeoutDialog();
    }
    if (error is DioError && (error.type == DioErrorType.response)) {
      if (error.response?.statusCode == 401) {
        return retry();
      }
    }

    return await Errors.reportAndShowOhNo(
      "Unexpected error during startup",
      error,
      stackTrace: stack,
      actions: [
        ReliableDialogButton(
            label: "RETRY",
            onPressed: () {
              splashRepo.checkForceUpdate(throwOnError: true);
            }),
      ],
    );
  }

  showTimeoutDialog() {
    GenericTimeoutDialog(
      actions: [
        ReliableDialogButton(
          label: "RETRY",
          dialogButtonType: DialogButtonTypes.SECONDARY,
          onPressed: () {
            NavigatorHelper().pop();
            retry();
          },
        ),
      ],
    ).show(dismissible: false);
  }

  retry() async {
    await startup();
  }

  void dispose(BuildContext context) {}
}
