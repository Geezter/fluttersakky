import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/timestamp.dart';
import 'package:kouluharjoittelu/style/styles.dart';

enum MessageMenu { edit, delete }

class TextInfo extends StatelessWidget {
  const TextInfo(
      {required this.name,
      required this.message,
      required this.sender,
      required this.date,
      super.key});
  final String name;
  final String sender;
  final String message;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          constraints: const BoxConstraints(
            minWidth: 200.0,
            maxWidth: double.infinity - 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                    color: const Color.fromARGB(
                        255, 187, 187, 187), // Set border color
                    width: 1.0, // Set border width
                  ),
              gradient: const LinearGradient(tileMode: TileMode.mirror, colors: [
                Color.fromARGB(184, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ]),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 0)),
                    date,
                    const Spacer(),
                  ],
                ),
              ),
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
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/anonymous_user.png',
                    width: 75,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 187, 187, 187), // Set border color
                    width: 1.0, // Set border width
                  ),
                  color: Color.fromARGB(255, 218, 218, 218)
                ),
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Styles.appBarDarkGray),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SelectableText(
                    message,
                    showCursor: true,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class TextInfoBot extends StatelessWidget {
  TextInfoBot({required this.message, required this.date, super.key});

  final String message;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 8),
          constraints: const BoxConstraints(
            minWidth: 200.0,
            maxWidth: double.infinity - 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                    color: const Color.fromARGB(
                        255, 187, 187, 187), // Set border color
                    width: 1.0, // Set border width
                  ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 224, 224, 224),
              ],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 0)),
                    date,
                    const Spacer(),
                  ],
                ),
              ),
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
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/logo3.png',
                    width: 75,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 187, 187, 187), // Set border color
                    width: 2.0, // Set border width
                  ),
                  color: Color.fromARGB(255, 218, 218, 218)
                ),
                child: Text(
                  'AbotI',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Styles.appBarDarkGray),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SelectableText(
                    message,
                    showCursor: true,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                      wordSpacing: 4,
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
