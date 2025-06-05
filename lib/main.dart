import 'package:flutter/material.dart';
import 'package:ios_fl_n_niagarafalls_3424/app.dart';
import 'package:ios_fl_n_niagarafalls_3424/ver_screen.dart';

class AppConstants {
  static const String oneSignalAppId = "94aa7adf-dd9a-4f9f-bdee-db2374eecce0";
  static const String appsFlyerDevKey = "v7xCW2oiGJ5JauPXwWiS5W";
  static const String appID = "6745502993";

  static const String baseDomain = "glorious-notable-exaltation.space";
  static const String verificationParam = "cao8JEDX";

  static const String splashImagePath = 'assets/images/l1.png';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final now = DateTime.now();
  final dateOff = DateTime(2024, 6, 7, 20, 00);

  final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';
  runApp(RootApp(
    initialRoute: initialRoute,
    whiteScreen: MainApp(),
  ));
}
