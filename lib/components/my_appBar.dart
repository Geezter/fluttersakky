import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/style/styles.dart';

enum MessageMenu { editProfile, botSettings, about }

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, required this.s});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String s;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Styles.appBarDarkGray,
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
                  fontSize: 25.0,
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
                      case MessageMenu.about:
                        Navigator.pushNamed((context), '/aboutPage');
                      default:
                    }
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    size: 25,
                    color: Styles.backgroundGray,
                  ),
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
