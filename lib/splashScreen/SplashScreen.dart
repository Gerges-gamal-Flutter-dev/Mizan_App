import 'package:flutter/material.dart'; // استيراد حزمة Flutter لبناء واجهة المستخدم.
import 'package:animated_splash_screen/animated_splash_screen.dart'; // استيراد مكتبة شاشة البداية المتحركة.
import 'package:flutter_mizan_app/Cache/cache_helper.dart'; // استيراد ملف مساعد التخزين المؤقت (Cache).
import 'package:flutter_mizan_app/HomePage/HomePage.dart'; // استيراد الصفحة الرئيسية.
import 'package:flutter_mizan_app/classes/ResponsiveScreen.dart'; // استيراد ملف يساعد في ضبط واجهة المستخدم بناءً على حجم الشاشة.
import '../HomePage/LoginPage.dart'; // استيراد صفحة تسجيل الدخول.

class SplashScreen extends StatelessWidget { // إنشاء فئة شاشة البداية (SplashScreen) وهي غير قابلة للتغيير (Stateless).
  const SplashScreen({super.key}); // مُنشئ للفئة مع مفتاح لتتبع الحالة في Flutter.

  static const route = 'splash'; // تعريف ثابت لمسار شاشة البداية.

  @override
  Widget build(BuildContext context) { // دالة build التي تبني واجهة المستخدم.
    ResponsiveScreen.initializeScreen(context); // استدعاء دالة لضبط أبعاد الشاشة اعتمادًا على حجم الجهاز.

    return FutureBuilder( // استخدام FutureBuilder للانتظار حتى يتم جلب البيانات من التخزين المؤقت.
      future: CacheHelper.containKey(key: 'email'), // التحقق مما إذا كان هناك مفتاح 'email' في التخزين المؤقت.
      builder: (context, snapshot) { // دالة البناء تعتمد على حالة الـ Future.
        if (snapshot.connectionState == ConnectionState.waiting) { // إذا كانت البيانات لا تزال في حالة التحميل.
          return const Center(child: CircularProgressIndicator()); // عرض دائرة تحميل.
        }

        if (snapshot.hasError) { // إذا كان هناك خطأ في جلب البيانات.
          return const Center(child: Text('Error loading splash screen')); // عرض رسالة خطأ.
        }

        bool hasEmail = snapshot.data ?? false; // الحصول على نتيجة التحقق من وجود 'email'، إذا لم توجد، افتراض أنها `false`.

        return AnimatedSplashScreen( // إنشاء شاشة البداية المتحركة.
          splashIconSize: ResponsiveScreen.screen_height, // تحديد حجم الأيقونة بما يناسب ارتفاع الشاشة.
          splash: Container( // إعداد محتوى شاشة البداية.
            alignment: Alignment.center, // محاذاة المحتوى في الوسط.
            child: Column( // استخدام عمود لترتيب المحتوى عموديًا.
              mainAxisAlignment: MainAxisAlignment.center, // جعل جميع العناصر في منتصف العمود.
              children: [
                Image.asset( // عرض صورة الشعار.
                  "assets/images/mizan.png", // مسار الصورة.
                  width: 200, // تحديد عرض الصورة.
                ),
                const Text( // نص ثابت يعرض اسم التطبيق.
                  'ميزان',
                  style: TextStyle(
                    color: Colors.white, // لون النص أبيض.
                    fontWeight: FontWeight.bold, // جعل النص غامقًا.
                    fontSize: 25, // حجم الخط.
                    fontFamily: 'Gulzar', // نوع الخط.
                  ),
                ),
              ],
            ),
          ),
          nextScreen: hasEmail ? HomePage() : const LoginPage(), // إذا كان البريد الإلكتروني موجودًا، الانتقال إلى الصفحة الرئيسية، وإلا الانتقال إلى صفحة تسجيل الدخول.
          backgroundColor: Colors.black, // جعل خلفية شاشة البداية سوداء.
          splashTransition: SplashTransition.scaleTransition, // استخدام تأثير تكبير لشاشة البداية.
          curve: Curves.easeOutBack, // تحديد منحنى الحركة لشاشة البداية.
          animationDuration: const Duration(seconds: 2), // تحديد مدة حركة شاشة البداية لتكون ثانيتين.
        );
      },
    );
  }
}
