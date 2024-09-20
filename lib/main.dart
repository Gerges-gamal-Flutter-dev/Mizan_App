import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
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
      theme: ThemeData(scaffoldBackgroundColor: kPrimaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
        titleTextStyle: TextStyle(color: kPrimaryColor4,fontSize: 20,fontWeight: FontWeight.bold),

      ),
      
 ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', ''),
      supportedLocales: const [
        // const Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}