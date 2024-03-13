import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';
import 'package:kouluharjoittelu/style/buttons.dart';
import 'package:kouluharjoittelu/style/styles.dart';

class UserVerifiedPage extends StatelessWidget {
  const UserVerifiedPage({required this.email, super.key});
  final String email;
  final double itemSize = 24;

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    final String email = arguments;
    return Scaffold(
      appBar: MyAppBar(s: 'Sähköposti vahvistettu'),
      body: Container(
        //height: screenHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Styles.backgroundGray, Styles.backgroundGray],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                    Navigator.pushNamed(context, '/chatBox', arguments: email);
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
