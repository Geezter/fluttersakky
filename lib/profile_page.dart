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
        height: double.infinity,
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
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                  borderRadius: BorderRadius.circular(500),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chatBox');
                    },
                    child: Image.asset(
                      'assets/images/anonymous_user.png',
                      width: 150,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  //border: Border.all(color: Colors.purple),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color.fromARGB(255, 221, 221, 221),
                        Color.fromARGB(255, 222, 222, 222)
                      ]),
                ),
                child: const Column(
                  children: [
                    ProfileItem(
                        myIcon: Icons.account_circle, myTitle: 'Pena Kamala'),
                    SizedBox(height: 8),
                    ProfileItem(
                        myIcon: Icons.email, myTitle: 'kamapena@hotmail.com'),
                    SizedBox(
                      height: 8,
                    ),
                    ProfileItem(
                        myIcon: Icons.access_time_filled_outlined,
                        myTitle: 'Kellohommia'),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    ProfileItem(myIcon: Icons.add_circle, myTitle: 'Tämmöstä'),
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
