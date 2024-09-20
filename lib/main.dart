import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mizan_app/HomePage/HomePage.dart';
import 'package:flutter_mizan_app/HomePage/LoginPage.dart';
import 'package:flutter_mizan_app/HomePage/signup.dart';
import 'package:flutter_mizan_app/Veiws/Organizing%20expenses.dart';
import 'package:flutter_mizan_app/Veiws/Personal%20data.dart';
import 'package:flutter_mizan_app/Veiws/View_installment.dart'; // تأكد من تطابق اسم الفئة
import 'package:flutter_mizan_app/Veiws/currency_exchange.dart'; // تأكد من تطابق اسم الفئة
import 'package:flutter_mizan_app/classes/Services%20.dart';
import 'package:flutter_mizan_app/constants/colors.dart';
import 'package:flutter_mizan_app/splashScreen/SplashScreen.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          titleTextStyle: TextStyle(
            color: kPrimaryColor4,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', ''),
      supportedLocales: const [
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/splash': (context) => const SplashScreen(),
        '/signup': (context) => const Signup(),
        '/currency_exchange': (context) =>  CurrencyExchange(), 
        '/Organization_expenses': (context) => const OrganizingExpenses(),
        '/personal': (context) => const PersonalData(), 
        '/view_installment': (context) => const ViewInstallment(),
      },
    );
  }
}
