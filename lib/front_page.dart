import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kouluharjoittelu/main.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(colors: [
              Color.fromARGB(221, 124, 157, 250),
              Color.fromARGB(189, 0, 10, 94)
            ]),
          ),
          //height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  child: Text('Well hello there,',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueAccent,
                        decoration: TextDecoration.none,
                      )),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/mainPage');
                    },
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/boxPage');
                          },
                          icon: const Icon(Icons.access_alarms)),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
