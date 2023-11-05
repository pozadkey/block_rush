import 'package:block_rush/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that the app runs in portrait mode only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
