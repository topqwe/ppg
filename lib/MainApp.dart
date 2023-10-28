import 'package:flutter/material.dart';
import 'AppUniversial.dart'
    if (dart.library.io) 'AppNative.dart'
    if (dart.library.html) 'AppWeb.dart' as platform;
// ignore: depend_on_referenced_packages

Future<void> mainApp() async {
  await platform.ensureApp();
  runApp(platform.MyApp(),
  );
}
