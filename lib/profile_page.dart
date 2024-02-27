import 'package:flutter/material.dart';
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
      appBar: MyAppBar(s: 'Profiili'),
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
        child: Text('Profiili'),
      ),
    );
  }
}
