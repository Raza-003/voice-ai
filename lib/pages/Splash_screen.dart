import 'dart:async';
import 'package:voice_ai/pages/get_start_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after a delay of 5 seconds using Timer
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => getStartPage(), // Replace with your next page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            focal: Alignment.center,
            radius: 0.7,
            colors: [
              Color.fromARGB(255, 214, 199, 255),
              Color(0xFFa98aff),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: LottieBuilder.asset(
                    "images/Animation - 1716996654364.json"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
