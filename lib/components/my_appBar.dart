import 'package:flutter/material.dart';

enum MessageMenu { editProfile, botSettings, about }

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, required this.s});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String s;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 0, 1, 21),
      title: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 9, 37, 108),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(239, 255, 255, 255),
                ),
              ),
              GestureDetector(
                child: PopupMenuButton<MessageMenu>(
                  color: Color.fromARGB(238, 255, 255, 255),
                  onSelected: (value) {
                    switch (value) {
                      case MessageMenu.editProfile:
                        Navigator.pushNamed(context, '/profilePage');
                      case MessageMenu.botSettings:
                        print('settings');
                        break;
                      case MessageMenu.about:
                        Navigator.pushNamed(context, '/registrationPage');
                      default:
                    }
                  },
                  icon: const Icon(Icons.more_vert, size: 15),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                          value: MessageMenu.editProfile,
                          child: Text('Käyttäjäprofiili')),
                      const PopupMenuItem(
                          value: MessageMenu.botSettings,
                          child: Text('Botin asetukset')),
                      const PopupMenuItem(
                          value: MessageMenu.about,
                          child: Text('Tietoja sovelluksesta')),
                    ];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
