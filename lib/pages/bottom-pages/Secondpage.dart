import 'package:voice_ai/global/colors.dart';
import 'package:voice_ai/pages/chat/New_chat.dart';
import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({super.key});

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  List demoHistory = [
    {
      'topic': 'Flutter Dev Discussion',
      'time': '08:00 PM',
      'question': 'Chat new page'
    },
    {
      'topic': 'Start Apple development discussion',
      'time': '08:50 PM',
      'question': 'apple development certification'
    },
    {
      'topic': 'Wordpress Dev',
      'time': '10:00 PM',
      'question': 'Count array of words'
    },
    {
      'topic': 'Webpage ',
      'time': '06:00 AM',
      'question': 'Count r  latter in  word strawberry'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => NewChatpage()),
                  );
                },
                child: SizedBox(
                  height: 30,
                  child: Image.asset('images/post.png'),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Today"),
            Expanded(
              child: ListView.builder(
                itemCount: demoHistory.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) => NewChatpage()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Set the background color with opacity
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.3), // Shadow color with opacity
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(0, 3), // Offset of the shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              "images/bot.png",
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 210,
                                      child: Text(
                                        demoHistory[i]['topic'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(demoHistory[i]['time'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: darkColor,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  demoHistory[i]['question'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
