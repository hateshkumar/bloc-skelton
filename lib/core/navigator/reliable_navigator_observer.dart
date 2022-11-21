import 'package:flutter/material.dart';

import 'navigator_helper.dart';

class ReliableNavigatorObserver extends NavigatorObserver {
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    NavigatorHelper().routeLevelFromMain++;
  }

  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute == null) return;

    NavigatorHelper().routeLevelFromMain--;
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    //this triggers when we use pushNamedAndRemoveUntil
    // Log().debug("Did remove ${route?.settings?.name} -> ${previousRoute?.settings?.name}");
    if (previousRoute == null) return;
    NavigatorHelper().routeLevelFromMain--;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    //We are not using replace
    // globalBloc.hideSnackBar();
    print(newRoute?.settings.name);
  }
}
