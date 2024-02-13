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

Future<String> askChatAPI(String? token, String prompt) async {
  try {
    // Use the await keyword to make the HTTP POST request asynchronously.
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/chatgpt'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'token': token, 'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as String;
      return jsonResponse;
    } else {
      return ('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    return ('Error: $error');
  }
}

Future<String> handshake(String token) async {
  try {
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/handshake'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      print('success on handshake');
      return jsonResponse;
    }
    print('failed on handshake');
    return 'failed';
    //('Request failed with status: ${response.statusCode}.');
  } catch (error) {
    return ('Error: $error');
  }
}

Future<String> login(String email) async {
  try {
    // Use the await keyword to make the HTTP POST request asynchronously.
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse['token'];
    }
    return ('Request failed with status: ${response.statusCode}.');
  } catch (error) {
    return ('Error: $error');
  }
}

Future<String> verifyThis(String verificationEmail, String code) async {
  try {
    print(code);
    print('here in the api ${verificationEmail}');
    // Use the await keyword to make the HTTP POST request asynchronously.
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/verify'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'email': verificationEmail, 'code': code}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      print("body: ${response.body}");
      return jsonResponse['message'];
    } else {
      return ('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    return ('Error: $error');
  }
}
