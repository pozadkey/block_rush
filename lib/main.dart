import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Gordita',
        ),
        debugShowCheckedModeBanner: false,
        /* home: GameBoard(
        gameLevel: 200,
      ),*/
        home: const HomeScreen());
  }
}
