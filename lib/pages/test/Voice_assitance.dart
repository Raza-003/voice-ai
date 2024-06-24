// import 'package:voice_ai/components/Message_bubble.dart';
// import 'package:voice_ai/global/colors.dart';
// import 'package:voice_ai/routes/api_services.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class VoiceAssistancePage extends StatefulWidget {
//   const VoiceAssistancePage({super.key});

//   @override
//   State<VoiceAssistancePage> createState() => _VoiceAssistancePageState();
// }

// class _VoiceAssistancePageState extends State<VoiceAssistancePage> {
//   SpeechToText speechToText = SpeechToText();
//   var text = "Hold the button & start speaking";
//   var isListening = false;
//   final List<MessageBubble> messages = [];
//   var scrollController = ScrollController();
//   scrollMethod() {
//     scrollController.animateTo(scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterFloat,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 26),
//         child: AvatarGlow(
//           animate: isListening, //hold to listening
//           duration: Duration(milliseconds: 2800),
//           glowColor: bgcolor,
//           repeat: true,
//           glowCount: 2,
//           child: GestureDetector(
//             onTapDown: (details) async {
//               // isListening = true;
//               if (!isListening) {
//                 var available = await speechToText.initialize();
//                 if (available) {
//                   setState(() {
//                     isListening = true;
//                     speechToText.listen(
//                       onResult: (result) {
//                         setState(() {
//                           text = result.recognizedWords;
//                         });
//                       },
//                     );
//                   });
//                 }
//               }
//             },
//             onTapUp: (details) async {
//               setState(() {
//                 isListening = false;
//               });
//               await speechToText.stop();

//               messages.add(MessageBubble(
//                 text: text,
//                 type: messageType.user,
//               ));
//               var msg = await ApiServices.sendMessage(text);
//               setState(() {
//                 messages.add(MessageBubble(text: msg, type: messageType.bot));
//               });
//             },
//             child: CircleAvatar(
//               backgroundColor: bgcolor,
//               radius: 35,
//               child: Icon(
//                 isListening ? Icons.mic : Icons.mic_off,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       appBar: AppBar(
//         leading: Icon(
//           Icons.sort_sharp,
//           color: Colors.white,
//         ),
//         title: Text(
//           "Voice Assistant",
//           style: TextStyle(color: textcolor, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: bgcolor,
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 24,
//         ),
//         child: Column(
//           children: [
//             Text(
//               text,
//               style: TextStyle(
//                   fontSize: 22,
//                   color: isListening ? bgcolor : Colors.black45,
//                   fontWeight: FontWeight.w400),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: chatbgcolor,
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     controller: scrollController,
//                     shrinkWrap: true,
//                     itemCount: messages.length,
//                     itemBuilder: (BuildContext context, int i) {
//                       var chat = messages[i];
//                       return Bubble(
//                         chatText: chat.text,
//                         type: chat.type,
//                       );
//                     }),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             // Text("Powered by #")
//           ],
//         ),
//       ),
//     );
//   }

//   Widget Bubble({required chatText, required messageType? type}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CircleAvatar(
//           backgroundColor: bgcolor,
//           child: type == messageType.bot
//               ? Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Image.asset(
//                     'images/ChatGPT-Logo.png',
//                     color: Colors.white,
//                   ),
//                 )
//               : Icon(
//                   Icons.person,
//                   color: Colors.white,
//                 ),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(10),
//             margin: EdgeInsets.only(bottom: 15),
//             decoration: BoxDecoration(
//                 color: type == messageType.bot ? bgcolor : Colors.white,
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(10),
//                     bottomRight: Radius.circular(10),
//                     bottomLeft: Radius.circular(10))),
//             child: Text(
//               "$chatText",
//               style: TextStyle(
//                 color: type == messageType.bot ? textcolor : chatbgcolor,
//                 fontSize: 14,
//                 fontWeight:
//                     type == messageType.bot ? FontWeight.w600 : FontWeight.w300,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
