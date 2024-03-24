import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';
import 'package:kouluharjoittelu/components/text_info.dart';
import 'package:kouluharjoittelu/config/api.dart';
import 'package:kouluharjoittelu/style/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:kouluharjoittelu/components/timestamp.dart';
import 'package:auto_scroll/auto_scroll.dart';
import 'package:kouluharjoittelu/style/styles.dart';

enum NewChatMenu { newChat, email }

class ChatBox extends StatefulWidget {
  const ChatBox({required userEmail, super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final AutoScrollController _autoScrollController = AutoScrollController();
  final List _msgs = [];
  final FocusNode _focusNode = FocusNode();

  late Map<String, dynamic> messagesResult;

  Future<String> transferKnowledge(message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    String gptAnswer = await askChatAPI(token, message);
    if (gptAnswer == 'deleted') {
      return 'false';
    }
    return gptAnswer;
  }

  Future<void> _initMessages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('token', '');
    final String? token = prefs.getString('token');
    if (token != null && token != 'token') {
      var result = await getMessages(token);
      messagesResult = convert.jsonDecode(result);
      if (!messagesResult['rows'].isEmpty) {
        for (dynamic message in messagesResult['rows']) {
          updateUserMsgs(message['email'], message['message'], 'user',
              message['message_created_at']);

          updateBotMsgs(message['response'], message['response_created_at']);
        }
      }
    }
  }

  void _addMessage(name, message, sender) async {
    if (message != "") {
      setState(() {
        if (message == '/clear') {
          Navigator.pushNamed(context, '/chatBox', arguments: 'lorro');
          //_msgs.clear();

          return;
        }
        _msgs.add(
          TextInfo(
            name: name,
            message: message,
            sender: sender,
            date: Timestamp(),
          ),
        );
        _textEditingController.text = "";
      });
    }
    if (message != "") {
      String answer = await transferKnowledge(message);
      setState(() {
        if (answer != 'false') {
          _msgs.add(
            TextInfoBot(message: answer, date: Timestamp()),
          );
        }
      });
    }
    if (_msgs.isNotEmpty && _autoScrollController.hasListeners) {
      _autoScrollController.animateToAnchor(
        duration: const Duration(milliseconds: 4000),
        curve: Curves.easeOut,
      );
      _focusNode.requestFocus();
    }
  }

  Timestamp _timestampTemppu(date) {
    if (date != null) {
      DateTime kuu = DateTime.parse(date);
      date = Timestamp(time: kuu);
    }
    date ??= Timestamp();
    return date;
  }

  void updateBotMsgs(message, date) async {
    Timestamp stamp = _timestampTemppu(date);
    setState(() {
      _msgs.add(
        TextInfoBot(
          message: message,
          date: stamp,
        ),
      );
    });
  }

  void updateUserMsgs(name, message, sender, date) async {
    Timestamp stamp = _timestampTemppu(date);
    setState(() {
      _msgs.add(
        TextInfo(name: name, message: message, sender: sender, date: stamp),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initMessages().then((_) {
      if (_msgs.isNotEmpty) {
        // Delay the scrolling to ensure the list is built
        Future.delayed(const Duration(milliseconds: 100), () {
          _autoScrollController.animateToAnchor(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.linear,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    final String userEmail = arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(s: 'Chatbot'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoScroller(
              controller: _autoScrollController,
              lengthIdentifier: _msgs.length * 50 + 10,
              anchorThreshold: 0,
              startAnchored: false,
              builder: (context, autoScrollController) {
                if (_msgs.isEmpty) {
                  return Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/chatBox');
                        },
                        child: Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            'assets/images/logo3.png',
                            width: 400,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: autoScrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: _msgs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(0),
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 20,
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  tileMode: TileMode.mirror,
                                  colors: [
                                    Styles.backgroundGray,
                                    Styles.paintersWhite,
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  _msgs[index],
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      //const SizedBox(height: 15),
                    ],
                  );
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Styles.appBarDarkGray),
            height: 70 + MediaQuery.of(context).viewInsets.bottom,
            child: Column(
              children: [
                const SizedBox(height: 3),
                Padding(
                  padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: [
                      GestureDetector(
                        onLongPress: () {},
                        child: PopupMenuButton<NewChatMenu>(
                          onSelected: (value) {
                            switch (value) {
                              case NewChatMenu.newChat:
                                _addMessage(
                                  userEmail,
                                  "/clear",
                                  'user',
                                );
                                break;
                              case NewChatMenu.email:
                                Navigator.pop(context);
                              default:
                            }
                          },
                          icon: Icon(
                            Icons.new_label,
                            color: Styles.backgroundGray,
                          ),
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: NewChatMenu.newChat,
                                child: Text('New chat'),
                              ),
                              const PopupMenuItem(
                                value: NewChatMenu.email,
                                child: Text('Close chat'),
                              ),
                            ];
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Styles.backgroundGray,
                              ),
                            ),
                            hintText: 'Mikä askarruttaa?',
                            hintStyle: TextStyle(
                              color: Styles.backgroundGray,
                            ),
                          ),
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          style: TextStyle(
                            color: Styles.backgroundGray,
                          ),
                          onChanged: (value) {
                            _textEditingController.text = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                return Colors.white;
                              },
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) {
                                return myLightButtonBackgroundColor;
                              },
                            ),
                          ),
                          onPressed: () {
                            _addMessage(
                              userEmail,
                              _textEditingController.text,
                              'user',
                            );
                            _textEditingController.clear();
                          },
                          child: Text(
                            'Kysy',
                            style: TextStyle(
                              color: Styles.appBarDarkGray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
