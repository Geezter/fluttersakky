import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/timestamp.dart';

enum MessageMenu { edit, delete }

class TextInfo extends StatelessWidget {
  const TextInfo(
      {required this.name,
      required this.message,
      required this.sender,
      required this.alignment,
      super.key});

  final String name;
  final String sender;
  final String message;

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 300,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 53, 134, 254),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(padding: EdgeInsets.only(left: 8)),
                Timestamp(),
                (sender == 'user')
                    ? const Spacer()
                    : const SizedBox(
                        width: 8,
                      ),
                Text(name),
                (sender == 'other')
                    ? const Spacer()
                    : const SizedBox(
                        width: 8,
                      ),
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
            Align(
              alignment: alignment,
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 12)),
          ],
        ),
      ),
    );
  }
}
