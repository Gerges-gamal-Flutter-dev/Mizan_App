// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_mizan_app/HomePage/HomePage.dart';
import 'package:flutter_mizan_app/classes/ResponsiveScreen.dart';
import 'package:flutter_mizan_app/classes/Services%20.dart';

import '../HomePage/LoginPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const route = 'splash';

  @override
  Widget build(BuildContext context) {
    ResponsiveScreen.initializeScreen(context);
    return AnimatedSplashScreen(
      splashIconSize: ResponsiveScreen.screen_height,
      splash: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/mizan.png",
              width: 200, // تعديل الحجم ليكون أكثر تناسقًا
            ),
            const Text(
              'ميزان',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Gulzar',
              ),
            ),
          ],
        ),
      ),
      nextScreen: Services.containKey(key: 'email') ? const HomePage() : const LoginPage(),
      backgroundColor: Colors.black,
      splashTransition: SplashTransition.scaleTransition,
      curve: Curves.easeOutBack,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
