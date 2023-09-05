import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/main_page.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 9, 37, 108),
          title: Text('Da crap'),
        ),
        
        body: 
        MainPage());
  }
}
