import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/style/styles.dart';
import 'package:kouluharjoittelu/style/buttons.dart';

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
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Colors.black,
                ),
                child: Text(
                  'Chatbot 2029',
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Styles.botGray,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 64),
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
              const SizedBox(height: 64),
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      height: 100,
                      width: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return Colors.white;
                            },
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return myButtonBackgroundColor;
                          }),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/registrationPage');
                        },
                        icon: const Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                        label: const Text(
                          'Aktivoi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
