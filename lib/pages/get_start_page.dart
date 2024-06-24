import 'dart:async';

import 'package:voice_ai/global/colors.dart';
import 'package:voice_ai/pages/bottom-bar/bottom.dart';
import 'package:flutter/material.dart';

class getStartPage extends StatefulWidget {
  const getStartPage({super.key});

  @override
  State<getStartPage> createState() => _getStartPageState();
}

class _getStartPageState extends State<getStartPage> {
  PageController slider1Controller = PageController();
  int slider1 = 0;
  bool isSlider1Reverce = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (slider1 < 3) {
        slider1++;
        if (slider1Controller.hasClients) {
          slider1Controller.animateToPage(
            slider1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      } else {
        slider1 = 0;
        if (slider1Controller.hasClients) {
          slider1Controller.animateToPage(
            slider1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  List image = [
    {
      'image': Image.asset(
        'images/chatbot.png',
        height: 200,
      ),
      'title': "Hello, it's Ally!",
      'subtitle1': 'Welcome to our AI assistant app!',
      'subtitle2': "We're excited to have you on",
      'subtitle3': 'board. Here are a few steps to',
      'subtitle4': 'help you get started.',
    },
    {
      'image': Image.asset(
        'images/chatbot (1).png',
        height: 200,
      ),
      'title': "Hello, it's Ally!",
      'subtitle1': 'Welcome to our AI assistant app!',
      'subtitle2': "We're excited to have you on",
      'subtitle3': 'board. Here are a few steps to',
      'subtitle4': 'help you get started.',
    },
    {
      'image': Image.asset(
        'images/chatbot (2).png',
        height: 200,
      ),
      'title': "Hello, it's Ally!",
      'subtitle1': 'Welcome to our AI assistant app!',
      'subtitle2': "We're excited to have you on",
      'subtitle3': 'board. Here are a few steps to',
      'subtitle4': 'help you get started.',
    },
  ];

  bool shouldSkip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: EdgeInsets.only(right: 25, top: 40),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Text(
          //         "Skip",
          //         style: TextStyle(
          //             color: Colors.grey.shade700, fontWeight: FontWeight.w500),
          //       ),
          //     ),
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     3,
          //     (index) => buildSlider1Dot(index: index),
          //   ),
          // ),
          Expanded(
            child: PageView.builder(
              itemCount: image.length,
              controller: slider1Controller,
              itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image[index]['image'],
                      SizedBox(height: 50),
                      Text(
                        image[index]['title'],
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        image[index]['subtitle1'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        image[index]['subtitle2'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        image[index]['subtitle3'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        image[index]['subtitle4'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  )),
              onPageChanged: (value) {
                setState(() {
                  slider1 = value;
                });
              },
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomeBottomBarPage()),
                ModalRoute.withName('/'),
              );
            },
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: darkColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        color: textcolor,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_circle_right_sharp,
                      color: textcolor,
                      size: 28,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  // AnimatedContainer buildSlider1Dot({int? index}) {
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 200),
  //     margin: EdgeInsets.only(right: 5),
  //     height: 8,
  //     width: 8,
  //     decoration: BoxDecoration(
  //       color: slider1 == index ? bgcolor : const Color(0xFFDADADA),
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //   );
  // }
}
