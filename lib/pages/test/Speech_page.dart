import 'package:voice_ai/global/colors.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MySpeechScreen extends StatefulWidget {
  const MySpeechScreen({super.key});

  @override
  State<MySpeechScreen> createState() => _MySpeechScreenState();
}

class _MySpeechScreenState extends State<MySpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  var text = "Hold the button & start speaking";
  var isListening = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Speech to Text",
          style: TextStyle(color: textcolor, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: bgcolor,
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          margin: EdgeInsets.only(bottom: 160),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22,
                color: isListening ? bgcolor : Colors.black45,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening, //hold to listening
        duration: Duration(milliseconds: 4000),
        glowColor: bgcolor,
        repeat: true,
        glowCount: 2,
        child: GestureDetector(
          onTapDown: (details) async {
            // isListening = true;
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: bgcolor,
            radius: 35,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
