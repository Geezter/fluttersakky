import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/fields/registration_items.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class MyMaterialStateColor extends MaterialStateColor {
  MyMaterialStateColor(int defaultValue) : super(defaultValue);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.red; // Change to the desired color for the pressed state
    }
    return const Color.fromARGB(
        255, 214, 96, 234); // Default color for other states
  }
}

MyMaterialStateColor myButtonBackgroundColor = MyMaterialStateColor(
  const Color.fromARGB(255, 149, 25, 171).value,
);

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(s: 'Rekisteröidy'),
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
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chatBox');
                  },
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                '"Ole hyvä ja rekisteröidy, niin voin palvella sinua paremmin"',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              const ProfileItem(
                  myIcon: Icons.account_circle,
                  myTitle: 'PenaKamala',
                  myHelperText: 'Käyttäjänimi',
                  myType: TextInputType.name),
              const SizedBox(height: 20),
              const ProfileItem(
                  myIcon: Icons.email,
                  myTitle: 'kamapena@hotmail.com',
                  myHelperText: 'Sähköposti',
                  myType: TextInputType.emailAddress),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 60,
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
                    print('You registered you little bitch!');
                  },
                  icon: const Icon(Icons.app_registration),
                  label: const Text(
                    'Rekisteröidy',
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
