import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API extends StatefulWidget {
  const API({super.key, required this.prompt});

  final Future<String> prompt;

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<String> askChatAPI(String prompt) async {
  try {
    // Use the await keyword to make the HTTP POST request asynchronously.
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/chatgpt'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as String;
      return jsonResponse;
    } else {
      return('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    return('Error: $error');
  }
}
