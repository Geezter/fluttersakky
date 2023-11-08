import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/fields/profile_items.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(s: 'Oma profiili'),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color.fromARGB(255, 49, 1, 121),
              Color.fromARGB(255, 0, 2, 23)
            ],
          ),
        ),
        //transform: Matrix4.identity()..scale(1.5),
        child: Container(
          margin: EdgeInsets.all(16),
          height: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.purple),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color.fromARGB(64, 16, 15, 56),
                        Colors.transparent
                      ]),
                ),
                child: const Column(
                  children: [
                    ProfileItem(
                        myIcon: Icons.account_circle,
                        myTitle: 'Pena Kamala'),
                    SizedBox(height: 8),
                    ProfileItem(
                        myIcon: Icons.email,
                        myTitle: 'kamapena@hotmail.com'),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileItem(
                        myIcon: Icons.access_time_filled_outlined,
                        myTitle: 'Kellohommia'),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    ProfileItem(
                        myIcon: Icons.add_circle, myTitle: 'Tämmöstä'),
                    SizedBox(height: 8),
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
