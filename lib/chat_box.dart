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
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final AutoScrollController _autoScrollController = AutoScrollController();
  final FocusNode _focusNode = FocusNode();
  final List _msgs = [];
  late Map<String, dynamic> messagesResult;
  late int amount = 0;
  late String userEmail;

  Future<String> transferKnowledge(message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    String gptAnswer = await askChatAPI(token, message);
    if (gptAnswer == 'deleted') {
      return 'false';
    }
    return gptAnswer;
  }

  void _addMessage(name, message, sender) async {
    if (message != "") {
      int i = 0;
      setState(() {
        if (message == '/clear') {
          _msgs.clear();
          return;
        }
        _msgs.add(
          TextInfo(
            name: name,
            message: message,
            sender: sender,
            date: Timestamp(),
            amount: i,
            total: amount,
          ),
        );
        _textEditingController.text = "";
        i++;
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
    if (_msgs.isNotEmpty) {
      _autoScrollController.animateToAnchor(
        duration: const Duration(milliseconds: 4000),
        curve: Curves.easeOut,
      );
      _focusNode.requestFocus();
    }
  }

  Future<void> _initMessages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('token', '');
    final String? token = prefs.getString('token');
    if (token != null && token != 'token') {
      var result = await getMessages(token);
      messagesResult = convert.jsonDecode(result);
      if (!messagesResult['rows'].isEmpty) {
        amount = messagesResult['rows'].length;
        for (dynamic message in messagesResult['rows']) {
          userEmail = message['email'];
          updateUserMsgs(message['email'], message['message'], 'user',
              message['message_created_at']);

          updateBotMsgs(message['response'], message['response_created_at']);
        }
      }
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
    int i = 0;
    setState(() {
      _msgs.add(
        TextInfo(
            name: name,
            message: message,
            sender: sender,
            date: stamp,
            amount: amount,
            total: i),
      );
    });
    i++;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(s: 'My Chatbot'),
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Container(
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
                              break;
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
                              child: Text('Email to me'),
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
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      body: AutoScroller(
        controller: _autoScrollController,
        lengthIdentifier: _msgs.length * 100,
        anchorThreshold: 50,
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
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: autoScrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 10,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ..._msgs,
                              ],
                            ),
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
    );
  }
}
