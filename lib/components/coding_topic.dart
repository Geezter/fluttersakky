import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';

// ignore: must_be_immutable
class CodingTopic extends StatefulWidget {
  CodingTopic({super.key, required this.language, required this.topic});

  String language;
  String topic;

  @override
  State<CodingTopic> createState() => _CodingTopicState();
}

class _CodingTopicState extends State<CodingTopic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.language),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(221, 15, 50, 23),
            Color.fromARGB(187, 1, 30, 51)
          ]),
        ),
        child: Center(
          child: Column(children: [
            const SizedBox(height: 24),
            Text(
              widget.topic,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  color: Colors.white),
              child: Center(
                child: Column(children: [
                  SizedBox(height: 24),
                  Text('Asiasta ${widget.language}',
                  style: TextStyle(fontSize: 24)
                  ),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
