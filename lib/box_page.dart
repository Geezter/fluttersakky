import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/config/routes.dart';
import 'package:kouluharjoittelu/style/styles.dart';


enum ProfileMenu { javascript, dart, php }

class BoxPage extends StatefulWidget {
  BoxPage({super.key});

  @override
  State<BoxPage> createState() => _BoxPageState();
}

class _BoxPageState extends State<BoxPage> {
  String language = 'JavaScript';

  updateLanguage(newLanguage) {
    setState(() {
      language = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(language),
        actions: [
          PopupMenuButton<ProfileMenu>(
              onSelected: (value) {
                switch (value) {
                  case ProfileMenu.javascript:
                    updateLanguage('JavaScript');
                    return;
                  case ProfileMenu.dart:
                    updateLanguage('Dart');
                    return;
                  case ProfileMenu.php:
                    updateLanguage('PHP');
                    return;
                }
              },
              icon: const Icon(Icons.code),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(child: Text('Javascript'), value: ProfileMenu.javascript),
                  PopupMenuItem(child: Text('Dart'), value: ProfileMenu.dart),
                  PopupMenuItem(child: Text('PHP'), value: ProfileMenu.php),
                ];
              })
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(221, 37, 93, 247),
            Color.fromARGB(189, 0, 10, 94)
          ]),
        ),
        child: SafeArea(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.codingTopic);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Color.fromARGB(255, 57, 56, 153),
                  child: const Text(
                    "Variables",
                    style: Styles.boxPageStyle,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Color.fromARGB(255, 77, 26, 153),
                child: const Text(
                  'Data types',
                  style: Styles.boxPageStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Color.fromARGB(255, 27, 26, 153),
                child: const Text(
                  'Control Structures',
                  style: Styles.boxPageStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Color.fromARGB(255, 57, 26, 123),
                child: const Text(
                  'Functions/Methods',
                  style: Styles.boxPageStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Color.fromARGB(255, 57, 26, 173),
                child: const Text(
                  'Arrays and Lists',
                  style: Styles.boxPageStyle,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Color.fromARGB(255, 57, 26, 173),
                child: const Text(
                  'Object-Oriented Programming',
                  style: Styles.boxPageStyle,
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   color: Color.fromARGB(255, 57, 26, 153),
              //   child: const Text('Exception Handling',
              //   style: Styles.boxPageStyle,
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   color: Color.fromARGB(255, 77, 46, 173),
              //   child: const Text('Object-Oriented Programming',
              //   style: Styles.boxPageStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
