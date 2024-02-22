import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/style/styles.dart';
import 'package:kouluharjoittelu/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  late Map<String, dynamic> handshakeResult;

  
  /// performs handshake with the backend, sends JWT token from
  /// shared preferences if there is one.
  /// Retunrs value based on the registration status of the user
  /// 
  Future<void> _performHandshake() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', '');
    final String? token = prefs.getString('token');
    if (token != null && token != 'token') {
      var verified = await handshake(token);
      handshakeResult = convert.jsonDecode(verified);
      goAhead(handshakeResult);
    }
  }

  /// Takes the user forward depending on the handshake result
  /// 
  void goAhead(handshakeResult) {
    if (handshakeResult['message'] == 'register') {
      Navigator.pushNamed(context, '/registrationPage');
    }

    if (handshakeResult['message'] == "verify") {
      Navigator.pushNamed(context, '/verificationPage',
          arguments: handshakeResult['email']);
    }
    if (handshakeResult['message'] == 'ok') {
      Navigator.pushNamed(context, '/chatBox');
    }
  }

  // Activates handshake when site is loaded
  @override
  void initState() {
    super.initState();
    _performHandshake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            radius: BorderSide.strokeAlignOutside,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255)
            ],
          ),
        ),
        //height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Text(
                  'AChatI+',
                  style: TextStyle(
                    //backgroundColor: Styles.backgroundGray,
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: Styles.botGray,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 64),
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/chatBox');
                  },
                  child: Image.asset(
                    'assets/images/logo3.png',
                    width: 300,
                  ),
                ),
              ),
              const SizedBox(height: 64),
              SizedBox(
                height: 100,
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      height: 100,
                      width: 350,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: (() {
                                Navigator.pushNamed(
                                    context, '/registrationPage');
                              }),
                              child: const Text(
                                'Aktivoi',
                                style: TextStyle(fontSize: 34),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
