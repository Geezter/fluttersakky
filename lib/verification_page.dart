import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';
import 'package:kouluharjoittelu/style/buttons.dart';
import 'package:kouluharjoittelu/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationPage extends StatefulWidget {
  final String? verificationEmail;

  const VerificationPage({this.verificationEmail, super.key});

  @override
  State<VerificationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<VerificationPage> {
  final TextEditingController _verificationEditingController =
      TextEditingController();
  late Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final double itemSize = 24;
  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    final String verificationEmail = arguments;
    print('verification with modal ${verificationEmail}');

    Future<String> transferKnowledge(verificationController) async {
      print("e-mail: ${verificationEmail}");
      String code = verificationController.text;
      String verified = await verifyThis(verificationEmail, code);
      return verified;
    }

    void advance() {
      print('advancing to verify done');
      Navigator.pushNamed(context, '/userVerifiedPage');
    }

    final screenHeight = MediaQuery.of(context).size.height - 150;

    void _verify(verificationController) async {
      final SharedPreferences prefs = await _prefs;
      print('menossa apiin');
      print(verificationController.text);
      String? verificationResponse =
        await transferKnowledge(verificationController);
      print("response: ${verificationResponse}");
      if (verificationResponse != 'failed') {
        final String token = verificationResponse;
        print('verifiointi tehty, token:  ' + token);
        //await prefs.setString('token', token);
        advance();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(s: 'Vahvista sähköpostisi'),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              height: screenHeight,
              width: double.infinity,
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                height: screenHeight,
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    Text(
                      'Vahvistuskoodi lähetetty sähköpostiosoitteeseen ${verificationEmail ?? ''}',
                    ),
                    Container(
                      child: SizedBox(
                        //height: 32,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Koodisi',
                            border: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ), // Set your desired color
                            ),
                          ),
                          controller: _verificationEditingController,
                          onChanged: (value) {
                            _verificationEditingController.text = value;
                          },
                          //initialValue: "plll",
                          style: TextStyle(
                              fontSize: itemSize - 4,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SizedBox(height: 120),
                    SizedBox(
                      height: 64,
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
                          print('You verified you little bitch!');
                          _verify(_verificationEditingController);
                          //_usernameEditingController.text = "";
                          //_emailEditingController.text = "";
                        },
                        icon: const Icon(Icons.verified_user_outlined),
                        label: const Text(
                          'Vahvista',
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
          ),
        );
      }),
    );
  }
}
