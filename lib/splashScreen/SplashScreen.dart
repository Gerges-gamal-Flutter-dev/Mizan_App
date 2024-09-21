/*الكود يستخدم مكتبة animated_splash_screen لعرض شاشة البداية.
يتم التحقق من وجود بريد إلكتروني مخزن في CacheHelper. إذا وجد، يتم توجيه المستخدم إلى الصفحة الرئيسية، وإذا لم يوجد يتم توجيهه إلى صفحة تسجيل الدخول.
شاشة البداية تتضمن صورة وشعار النص ميزان.
تستخدم الشاشة تأثيرات متحركة مثل تكبير الشاشة مع خلفية سوداء.
*/
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_mizan_app/Cache/cache_helper.dart';
import 'package:flutter_mizan_app/HomePage/HomePage.dart';
import 'package:flutter_mizan_app/classes/ResponsiveScreen.dart';
import '../HomePage/LoginPage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const route = 'splash';

  @override
  Widget build(BuildContext context) {
    ResponsiveScreen.initializeScreen(context);

    return FutureBuilder(
      future: CacheHelper.containKey(key: 'email'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading splash screen'));
        }

        bool hasEmail = snapshot.data ?? false;

        return AnimatedSplashScreen(
          splashIconSize: ResponsiveScreen.screen_height,
          splash: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/mizan.png",
                  width: 200, 
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
          nextScreen: hasEmail ? HomePage() : const LoginPage(),
          backgroundColor: Colors.black,
          splashTransition: SplashTransition.scaleTransition,
          curve: Curves.easeOutBack,
          animationDuration: const Duration(seconds: 2),
        );
      },
    );
  }
}
