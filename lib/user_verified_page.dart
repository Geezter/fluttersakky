import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';
import 'package:kouluharjoittelu/style/buttons.dart';


class UserVerifiedPage extends StatelessWidget {
  const UserVerifiedPage({super.key});

  final double itemSize = 24;

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(s: 'Sähköposti vahvistettu'),
      body: Container(
              //height: screenHeight,
              width: double.infinity,
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
              //transform: Matrix4.identity()..scale(1.5),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                //height: screenHeight,
                child: Column(
                  children: [
                    Spacer(),
                    //SizedBox(height: 120),
                    SizedBox(
                      height: 64,
                      width: 170,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return Colors.white;
                          }),
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return myButtonBackgroundColor;
                          }),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/chatBox');
                        },
                        icon: const Icon(Icons.done_sharp),
                        label: const Text(
                          'Jatka',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
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