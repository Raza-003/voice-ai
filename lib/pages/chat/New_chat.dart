import 'package:voice_ai/global/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:typed_data';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class NewChatpage extends StatefulWidget {
  const NewChatpage({super.key});

  @override
  State<NewChatpage> createState() => _NewChatpageState();
}

class _NewChatpageState extends State<NewChatpage> {
  final Gemini gemini = Gemini.instance;
  final TextEditingController newChat = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';

  late final ChatUser geminiUser;

  @override
  void initState() {
    super.initState();
    geminiUser = ChatUser(id: "1", firstName: "Gemini");
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    setState(() {
      _isListening = true;
      newChat.clear(); // Clear the text field when starting speech recognition
    });
    await _speechToText.listen(
      onResult: (result) {
        _onSpeechResult(result);
        _stopListening(); // Automatically stop listening once speech is recognized
      },
    );
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
      if (_lastWords.isNotEmpty) {
        _onSendMessage(_lastWords);
        _lastWords = ''; // Clear the recognized words after sending
      }
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      print('Recognized words: $_lastWords'); // Debug print
    });
  }

  speak(String message) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(message);
  }

  List<Map<String, dynamic>> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ally",
          style: TextStyle(fontWeight: FontWeight.w600, color: darkColor),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print("object");
                },
                child: SizedBox(
                  height: 40,
                  child: Image.asset('images/bot.png'),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Column(
                    children: [
                      MessageBubble(
                        content: messages[index]['text'],
                        isCurrentUserMessage: messages[index]
                            ['isCurrentUserMessage'],
                        timestamp: messages[index]['timestamp'],
                      ),
                      messages[index]['isCurrentUserMessage']
                          ? Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () => speak(messages[index]['text']),
                                icon: Icon(Icons.volume_up),
                              ),
                            )
                          : Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () => speak(messages[index]['text']),
                                icon: Icon(Icons.volume_up),
                              ),
                            )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 3, left: 10),
                    decoration: BoxDecoration(
                      color: neonColor,
                      border: Border.all(
                        width: 1,
                        color: darkColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onLongPressStart: (_) => _startListening(),
                          onLongPressEnd: (_) => _stopListening(),
                          child: Icon(Icons.mic),
                        ),
                        SizedBox(width: 10),
                        _isListening
                            ? SizedBox(
                                width: 48,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.lineScale,
                                  colors: [darkColor],
                                  strokeWidth: 3,
                                ))
                            : Expanded(
                                child: TextField(
                                  controller: newChat,
                                  cursorColor: textcolor,
                                  keyboardType: TextInputType.multiline,
                                  enabled:
                                      !_isListening, // Disable the text field when listening
                                  decoration: InputDecoration(
                                    fillColor: textcolor,
                                    hintText: 'Type your message...',
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    _onSendMessage(newChat.text);
                    newChat.clear();
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: neonColor,
                      border: Border.all(
                        width: 1,
                        color: darkColor,
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Icon(
                      Icons.send,
                      color: darkColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSendMessage(String text) {
    if (text.trim().isEmpty) return; // Don't send empty messages
    setState(() {
      // Add the message to the list of messages
      messages.insert(0, {
        'text': text,
        'isCurrentUserMessage': true,
        'timestamp': Timestamp.now(),
      });
    });

    // Handle gemini response
    try {
      gemini.streamGenerateContent(text).listen((event) {
        final response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";
        setState(() {
          messages.insert(0, {
            'text': response,
            'isCurrentUserMessage': false,
            'timestamp': Timestamp.now(),
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }
}

class MessageBubble extends StatelessWidget {
  final dynamic content;
  final bool isCurrentUserMessage;
  final Uint8List? image;

  final Timestamp timestamp;

  MessageBubble({
    Key? key,
    required this.content,
    required this.isCurrentUserMessage,
    required this.timestamp,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime =
        "${dateTime.hour}:${dateTime.minute} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";

    return Align(
      alignment:
          isCurrentUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isCurrentUserMessage ? neonColor : darkColor,
          borderRadius: isCurrentUserMessage
              ? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (image != null)
              Image.memory(
                image!,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            if (content != null)
              SelectableText(
                content,
                style: TextStyle(
                  color: isCurrentUserMessage ? darkColor : textcolor,
                ),
              ),
            Text(
              formattedTime,
              style: TextStyle(
                  color: isCurrentUserMessage ? darkColor : textcolor,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
