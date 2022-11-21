import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../widgets/not_found.dart';


class RouteHandlers {
  static Handler notFoundHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return NotFoundScreen();
    // return;
  });


  static Handler makeHandler(Function creator) =>
      Handler(handlerFunc: (context, parameters) => creator());

}
