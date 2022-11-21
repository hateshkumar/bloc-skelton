import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/config.dart';
import 'config/config_dev.dart';
import 'config/firebase_config.dart';
import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Config.initialize(Flavor.DEV, DevConfig());
  await FirebaseMessagingManager().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}
