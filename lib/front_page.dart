import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/style/styles.dart';

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
          gradient: RadialGradient(
            radius: BorderSide.strokeAlignOutside,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        //height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 0, 0, 0),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chatBox');
                  },
                  child: Image.asset(
                    'assets/images/logo2.png',
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
        ),
      ),
    );
  }
}
