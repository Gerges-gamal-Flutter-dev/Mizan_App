import 'package:flutter/material.dart'; // استيراد مكتبة Flutter لبناء واجهة المستخدم.

class ScreenSize {
  static late double width;  // متغير ثابت (static) يمثل عرض الشاشة، يتم تعيينه لاحقًا (late).
  static late double height; // متغير ثابت (static) يمثل ارتفاع الشاشة، يتم تعيينه لاحقًا (late).

  static void intial(BuildContext context) { // دالة ثابتة (static) تقوم بتهيئة القيم.
    width = MediaQuery.of(context).size.width;  // تعيين عرض الشاشة باستخدام MediaQuery.
    height = MediaQuery.of(context).size.height; // تعيين ارتفاع الشاشة باستخدام MediaQuery.
  }
}
