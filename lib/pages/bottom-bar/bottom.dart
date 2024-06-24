import 'package:voice_ai/global/colors.dart';
import 'package:voice_ai/pages/auth/Login_page.dart';
import 'package:voice_ai/pages/bottom-pages/Firstpage.dart';
import 'package:voice_ai/pages/bottom-pages/Fourthpage.dart';
import 'package:voice_ai/pages/bottom-pages/Secondpage.dart';
import 'package:voice_ai/pages/bottom-pages/Thirdpage.dart';
import 'package:voice_ai/pages/test/demo.dart';
import 'package:flutter/material.dart';

class HomeBottomBarPage extends StatefulWidget {
  const HomeBottomBarPage({super.key});

  @override
  State<HomeBottomBarPage> createState() => _HomeBottomBarPageState();
}

class _HomeBottomBarPageState extends State<HomeBottomBarPage> {
  int currentIndex = 0;
  List barClass = [
    FirstPage(),
    Secondpage(),
    LoginPage(),
    // Thirdpage(),
    Fourthpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: barClass[currentIndex],
      bottomNavigationBar: SizedBox(
          height: 75,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                  child: Image.asset('images/geometry.png',
                      height: 25,
                      color: currentIndex == 0 ? darkColor : Colors.grey),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                  child: Image.asset('images/chat.png',
                      height: 25,
                      color: currentIndex == 1 ? darkColor : Colors.grey),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                  child: Image.asset('images/setting.png',
                      height: 25,
                      color: currentIndex == 2 ? darkColor : Colors.grey),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  child: Image.asset('images/person.png',
                      height: 25,
                      color: currentIndex == 3 ? darkColor : Colors.grey),
                ),
              ),
            ],
          )),
    );
  }
}
