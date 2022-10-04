import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

/// Using animated splash screen package for splash screen animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      splashIconSize: 200.0,
      backgroundColor: Color.fromRGBO(96, 143, 223, 1),
      nextScreen: Home(),
      splash: Image.asset(
        "images/vault.png",
      ),
      //using rotating animation
      splashTransition: SplashTransition.rotationTransition,
      duration: 1000,
    ));
  }
}
