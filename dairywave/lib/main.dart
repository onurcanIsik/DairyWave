import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/colors.dart';
import 'core/view/home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: mainColor,
        ),
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: bgColor,
      logo: Image.asset("assets/images/dairybox_nobg.png"),
      logoWidth: 70,
      title: Text(
        "Dairy Wave",
        style: GoogleFonts.rowdies(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: txtColor,
        ),
      ),
      loaderColor: mainColor,
      loadingText: Text(
        "version 1.0.2",
        style: GoogleFonts.kalam(),
      ),
      durationInSeconds: 4,
      navigator: const HomePage(),
    );
  }
}
