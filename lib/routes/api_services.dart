// // import 'package:flutter/material.dart';

// import 'dart:convert';

// import 'package:http/http.dart' as http;

// String apikey = "";

// class ApiServices {
//   static String baseUrl = "https://api.openai.com/v1/chat/completions";

//   static Map<String, String> header = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $apikey',
//   };

//   static sendMessage(String? message) async {
//     var res = await http.post(
//       Uri.parse(baseUrl),
//       headers: header,
//       body: jsonEncode({
//         "model": "gpt-3.5-turbo-0125",
//         // "system_fingerprint": "fp_44709d6fcb",
//         "prompt": '$message',
//         "temperature": 0,
//         "max_tokens": 100,
//         "top_p": 1,
//         "frequency_penalty": 0.0,
//         "presence_penalty": 0.0,
//         "stop": ["Human:", "AI:"]
//       }),
//     );

//     if (res.statusCode == 200) {
//       print(res.body.toString());
//       var data = jsonDecode(res.body.toString());
//       var msg = data['choices'][0]['text'];
//       return msg;
//     } else {
//       print("Failed to Fetch data");
//     }
//   }
// }
