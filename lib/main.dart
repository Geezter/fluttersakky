import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/box_page.dart';
import 'package:kouluharjoittelu/front_page.dart';
import 'package:kouluharjoittelu/main_page.dart';


void main() {
  runApp(MaterialApp(
    routes: {
        '/': (context) => FrontPage(),
        '/mainPage': (context) => MainPage(),
        '/boxPage': (context) => BoxPage(),
      },
      initialRoute: '/',
    ));
}
