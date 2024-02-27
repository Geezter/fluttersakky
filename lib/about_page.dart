import 'package:kouluharjoittelu/components/my_appBar.dart';
import "package:kouluharjoittelu/style/styles.dart";
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage
({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(s: 'Tietoja ohjelmasta'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(255, 193, 193, 193),
              Color.fromARGB(255, 230, 232, 250)
            ],
          ),
        ),
        child:
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 187, 187, 187), // Set border color
                    width: 1.0, // Set border width
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chatBox');
                    },
                    child: Image.asset(
                      'assets/images/logo3.png',
                      width: 150,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    const Text('AChatI'),
                    const SizedBox(height: 8),
                    const Text('ChatGPT App created by Jarkko Rissanen.'),
                    const Spacer(),
                    ElevatedButton(onPressed: () {

                    }, child: Text('Click here to delete your message history'),),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
      );
  }
}

