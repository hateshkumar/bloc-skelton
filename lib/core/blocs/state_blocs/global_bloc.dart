//This bloc will contain the db paths etc and other properties
//Init Db will be there

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reliable_hands/config/export.dart';
import 'package:rxdart/rxdart.dart';

import '../../navigator/navigator_helper.dart';
import '../../widgets/dialog/reliable_error_dialogs.dart';

enum SystemStyle {
  DEFAULT,
  POST,
}

/// Global logic
class GlobalBloc {
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>(debugLabel: 'global:scaffold');
  final GlobalKey<ScaffoldMessengerState> mainScreenScaffoldKey =
      GlobalKey<ScaffoldMessengerState>(
          debugLabel: 'global:mainscreenscaffold');

  final resetGoogleMap = BehaviorSubject<bool>.seeded(false);

  Function(bool) get updateResetGoogleMapFlag => resetGoogleMap.add;

  final _connectionErrorSnackbarSubject = BehaviorSubject<bool>();
  final _httpErrorSnackbarSubject = BehaviorSubject<SnackBar>();
  final isAppFunctional$ = BehaviorSubject<bool>.seeded(false);

  Function(bool) get setIsAppFunctional => isAppFunctional$.add;

  bool get isAppFunctional => isAppFunctional$.value;
  bool initialized = false;

  GlobalBloc() {
    _connectionErrorSnackbarSubject
        .throttleTime(const Duration(milliseconds: 6000))
        .listen((_) => _showConnectionErrorSnackBar());
    _httpErrorSnackbarSubject
        .throttleTime(const Duration(milliseconds: 6000))
        .listen((snackbar) => showSnackBar(snackbar: snackbar));
  }

  /// Idempotent!
  /// Initialize all app things that require a logged in user
  /// Currently this is run from the NavigatorHelper
  /// but ideally it'd be run somewhere else, somewhere more central
  initializeGlobalState() async {
    if (initialized) return;
    // Optimistic about initialisation
    initialized = true;
    setIsAppFunctional(true);
  }

  showSnackBar({
    String? message,
    Widget? content,
    SnackBarAction? action,
    Duration? duration,
    bool main = false,
    bool both = false,
    SnackBar? snackbar,
  }) {
    //if snackBar is provided it will override everything
    assert(!(message != null && content != null), 'Mutually exclusive');
    // Duration Material spec: min 4s, max 10s
    // This works OK for notifications
    if (duration == null && action == null) {
      duration = const Duration(milliseconds: 4000);
    }
    // Actionable snackbars should stick around for a bit
    if (duration == null && action != null) {
      duration = const Duration(milliseconds: 6000);
    }

    if (message != null) {
      content = Text(message);
    }
    if (snackbar != null) {
      snackbar = SnackBar(
        backgroundColor: APPColors.appPrimaryColor,
        content: GestureDetector(onTap: hideSnackBar, child: snackbar.content),
        duration: snackbar.duration,
        action: snackbar.action,
      );
    }
    final snack = snackbar ??
        SnackBar(
          content: GestureDetector(onTap: hideSnackBar, child: content),
          duration: duration!,
          action: action,
        );

    //Hide previous first
    hideSnackBar();
    hideSnackBar(main: true);

    if (main) {
      mainScreenScaffoldKey.currentState?.showSnackBar(snack);
    } else {
      rootScaffoldMessengerKey.currentState?.showSnackBar(snack);
    }
  }

  _showConnectionErrorSnackBar() {
    showSnackBar(
      message: "Please check your connection",
      action: SnackBarAction(
        label: "DISMISS",
        onPressed: () {},
      ),
      duration: const Duration(milliseconds: 4000),
    );
  }

  showConnectionErrorSnackBar() {
    _connectionErrorSnackbarSubject.add(true);
  }

  showHttpErrorSnackBar(SnackBar snackbar) {
    _httpErrorSnackbarSubject.add(snackbar);
  }

  showDisabledForAlphaSnackBar() => showSnackBar(
        // message: Platform.isIOS
        message: false ? 'Feature coming soon!' : 'Disabled for alpha — sorry!',
        action: SnackBarAction(
          label: "OH OK",
          onPressed: () {},
        ),
      );

  showValidationFailedDialog() {
    showReliableDialog(
      ValidationErrorDialog.fromErrors(
        title: 'Validation Failed',
        defaultMessage: "Some of the validation failed please have a look.",
      ),
    );
  }

  // Doesn't want to go away
  showStubbornSnackBar({
    required String message,
    Widget? content,
    required SnackBarAction action,
  }) =>
      showSnackBar(
          message: message,
          content: content,
          action: action,
          duration: const Duration(seconds: 300));

  hideSnackBar({bool main = true}) {
    //if scaffold keys are not linked to the scaffold just return
    if (mainScreenScaffoldKey.currentContext == null ||
        scaffoldKey.currentContext == null) return;
    if (main) mainScreenScaffoldKey.currentState?.hideCurrentSnackBar();
    scaffoldKey.currentState?.hideCurrentSnackBar();
  }

  /// If [localized = false] it will use the the build context
  /// in which the password with [scaffoldKey] key builds to show the dialog
  Future<T?> showReliableDialog<T>(
    Widget dialog, {
    bool dismissible = true,
    bool localized = true,
  }) {
    BuildContext context = localized
        ? NavigatorHelper.navigatorKey.currentContext!
        : scaffoldKey.currentContext!;
    return showDialog<T>(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: dismissible,
    );
  }

  showConnectionErrorDialog([DioError? error]) {
    // Could perhaps use the DioError to distinguish
    return showReliableDialog(noConnectionDialog);
  }

  reset() {
    setIsAppFunctional(false);
  }
}

final globalBloc = GlobalBloc();
