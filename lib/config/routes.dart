import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/box_page.dart';
import 'package:kouluharjoittelu/components/coding_topic.dart';
import 'package:kouluharjoittelu/front_page.dart';
import 'package:kouluharjoittelu/main_page.dart';

class AppRoutes {
  static final pages = {
    main: (context) => FrontPage(),
    front: (context) => MainPage(),
    box: (context) => BoxPage(),
    codingTopic: (context) => CodingTopic(language: "JavaScript", topic: "Plärinää"),
  };

  static const main = '/';
  static const front = '/mainPage';
  static const box = '/boxPage';
  static const codingTopic = '/codingTopic';
}
