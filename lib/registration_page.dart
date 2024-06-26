import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';
import 'package:kouluharjoittelu/config/api.dart';
import 'package:kouluharjoittelu/style/buttons.dart';
import 'package:kouluharjoittelu/style/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kouluharjoittelu/style/styles.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

String verificationEmail = "";

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  bool isThisEnabled = true;

  final double itemSize = 24;
  @override
  Widget build(BuildContext context) {
    Future<String> transferKnowledge(_emailEditingController) async {
      final String email = _emailEditingController.text;
      String registered = await login(email);
      return registered;
    }

    void verify(verificationEmail) {
      Navigator.pushNamed(context, '/verificationPage',
          arguments: verificationEmail);
    }

    void _register(_emailEditingController) async {
      setState(() {
        isThisEnabled = false;
      });

      String registeringResponse =
          await transferKnowledge(_emailEditingController);
      if (registeringResponse.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', registeringResponse);
        verify(_emailEditingController.text);
      }
      isThisEnabled = true;
    }

    final screenHeight = MediaQuery.of(context).size.height - 150;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(s: 'Kirjaudu sisään'),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [
                    Styles.backgroundGray,
                    Styles.backgroundGray],
                ),
              ),
              //transform: Matrix4.identity()..scale(1.5),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                height: screenHeight,
                child: Column(
                  children: [
                    //const SizedBox(height: 32),
                    const Spacer(),
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
                            'assets/images/logo3.png',
                            width: 200,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '"PIM! Olet hypnotisoitu. Kirjaudu."',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    // Container(
                    //   height: 64,
                    //   width: double.infinity,
                    //   alignment: Alignment.centerLeft,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 8, vertical: 0),
                    //   decoration: BoxDecoration(
                    //     color: const Color.fromARGB(255, 255, 255, 255),
                    //     borderRadius: const BorderRadius.all(
                    //       Radius.circular(5),
                    //     ),
                    //     border: Border.all(
                    //       color: Styles.botGray, // Set border color
                    //       width: 1.0, // Set border width
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(
                    //         Icons.account_circle,
                    //         size: itemSize,
                    //         color: const Color.fromARGB(255, 0, 0, 0),
                    //       ),
                    //       const SizedBox(width: 12),
                    //       Expanded(
                    //         child: SizedBox(
                    //           //height: 32,
                    //           child: TextFormField(
                    //             enabled: isThisEnabled,
                    //             decoration: const InputDecoration(
                    //               hintText: 'Käyttäjänimi',
                    //               border: InputBorder.none,
                    //               focusedBorder: UnderlineInputBorder(
                    //                 borderSide: BorderSide(
                    //                   color: Color.fromARGB(255, 0, 0, 0),
                    //                 ), // Set your desired color
                    //               ),
                    //             ),
                    //             controller: _usernameEditingController,
                    //             onChanged: (value) {
                    //               _usernameEditingController.text = value;
                    //             },
                    //             //initialValue: "plll",
                    //             style: TextStyle(
                    //                 fontSize: itemSize - 4,
                    //                 color: const Color.fromARGB(255, 0, 0, 0),
                    //                 fontWeight: FontWeight.w300),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         //height: 26,
                    //         //width: 24,
                    //         child: IconButton(
                    //           alignment: Alignment.centerRight,
                    //           iconSize: itemSize,
                    //           onPressed: () {
                    //             print('Tämä käyttäjänimi näkyy sinulle');
                    //           },
                    //           icon: Icon(
                    //             Icons.info_outline_rounded,
                    //             color: const Color.fromARGB(255, 0, 0, 0),
                    //             size: itemSize - 2,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //const Spacer(),
                    const SizedBox(height: 32),
                    Container(
                      height: 64,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(253, 255, 255, 255),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: const Color.fromARGB(
                              255, 187, 187, 187), // Set border color
                          width: 1.0, // Set border width
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.email,
                            size: itemSize,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SizedBox(
                              //height: 32,
                              child: TextFormField(
                                enabled: isThisEnabled,
                                decoration: const InputDecoration(
                                  hintText: 'sinunposti@jotain.fi',
                                  border: InputBorder.none,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0,
                                            0)), // Set your desired color
                                  ),
                                ),
                                controller: _emailEditingController,
                                onChanged: (value) {
                                  _emailEditingController.text = value;
                                },
                                //initialValue: "trups",
                                style: TextStyle(
                                    fontSize: itemSize - 4,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          SizedBox(
                            //height: 26,
                            //width: 24,
                            child: IconButton(
                              alignment: Alignment.centerRight,
                              iconSize: itemSize,
                              onPressed: () {
                              },
                              icon: Icon(
                                Icons.info_outline_rounded,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                size: itemSize - 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    //const Spacer(),
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
                          _register(_emailEditingController);
                          //_usernameEditingController.text = "";
                          //_emailEditingController.text = "";
                        },
                        icon: const Icon(Icons.app_registration),
                        label: const Text(
                          'Kirjaudu',
                          style: TextStyle(
                            fontSize: 18,
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
