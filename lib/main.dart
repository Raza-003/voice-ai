import 'package:voice_ai/pages/Splash_screen.dart';
import 'package:voice_ai/pages/auth/Login_page.dart';
import 'package:voice_ai/pages/bottom-bar/bottom.dart';
import 'package:voice_ai/pages/test/demo.dart';
import 'package:voice_ai/pages/test/test.dart';
import 'package:voice_ai/routes/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      // home: const SplashScreen(),
      // home: const HomeBottomBarPage(),
      // home: const Demopage(),
      home: const LoginPage(),
    );
  }
}
