import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/timestamp.dart';

enum MessageMenu { edit, delete }

class TextInfo extends StatelessWidget {
  const TextInfo(
      {required this.name,
      required this.message,
      required this.sender,
      super.key});
  final String name;
  final String sender;
  final String message;

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
          decoration: const BoxDecoration(
              gradient: LinearGradient(tileMode: TileMode.mirror, colors: [
                Color.fromARGB(184, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ]),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20))),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  const Timestamp(),
                  const Spacer(),
                  PopupMenuButton<MessageMenu>(
                    onSelected: (value) {
                      switch (value) {
                        case MessageMenu.edit:
                          Navigator.pushNamed(context, '/profilePage');
                        case MessageMenu.delete:
                          print('delete');
                          break;
                        default:
                      }
                    },
                    icon: const Icon(Icons.edit, size: 15),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                            value: MessageMenu.edit,
                            child: Text('Edit Profile')),
                        const PopupMenuItem(
                            value: MessageMenu.delete, child: Text('Delete')),
                      ];
                    },
                  ),
                ],
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
                    'assets/images/user_logo.png',
                    width: 75,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text(
                  'You',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    message,
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
  const TextInfoBot({required this.message, super.key});

  final String message;

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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 224, 224, 224),
              ],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  Timestamp(),
                  const Spacer(),
                  PopupMenuButton<MessageMenu>(
                    onSelected: (value) {
                      switch (value) {
                        case MessageMenu.edit:
                          print('edit da shit');
                          return;
                        case MessageMenu.delete:
                          print('log out');
                          break;
                        default:
                      }
                    },
                    icon: const Icon(Icons.menu_open_sharp, size: 15),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                            value: MessageMenu.edit, child: Text('Edit')),
                        const PopupMenuItem(
                            value: MessageMenu.delete, child: Text('Delete')),
                      ];
                    },
                  ),
                ],
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
                    'assets/images/logo2zoom.png',
                    width: 75,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text(
                  'Herrabotti',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
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
