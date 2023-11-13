import 'package:flutter/material.dart';
import 'package:block_rush/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Simulate a delay before navigating to the Home screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(), // Navigate to home screen
        ),
      );
    });

    // Start the animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1), // Animation duration
          curve: Curves.easeIn, // Easing curve
          width: opacity == 1.0 ? 500 : 0, // Slide in effect
          child: Image.asset(
            'assets/images/logo.png',
            scale: 3,
          ),
        ),
      ),
    );
  }
}
