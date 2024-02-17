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
/// Sends promp to backend to send to ChatGPT. Gives token also.
/// Returns the answer.
/// 
Future<String> askChatAPI(String? token, String prompt) async {
  try {
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

/// 'Handshakes' the backend by giving token. Returns answer based on the
/// phase of login for the user
/// 
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
  } catch (error) {
    return ('Error: $error');
  }
}

/// Sends token to backend and gives in return all
/// message infos in database for the user
/// 
Future<String> getMessages(String token) async {
  try {
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/getmessages'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      return jsonResponse;
    }
    print('failed on getMessages');
    return 'failed';
  } catch (error) {
    return ('Error: $error');
  }
}

/// Performs login attempt with given email
/// Forwards to verifying email
/// 
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

/// Attempt to verify with the code which was sent to users email
/// 
Future<String> verifyThis(String verificationEmail, String code) async {
  try {
    var response = await http.post(
      Uri.parse('http://localhost:3000/api/verify'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({'email': verificationEmail, 'code': code}),
    );
    if (response.statusCode == 200) {
      var jsonResponse = await convert.jsonDecode(response.body);
      return jsonResponse['message'];
    } else {
      return ('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    return ('Error: $error');
  }
}
