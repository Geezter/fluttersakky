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

  Future<String> transferKnowledge(message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    String gptAnswer = await askChatAPI(token, message);
    return gptAnswer;
  }

  void _addMessage(name, message, sender) async {
    if (message != "") {
      setState(() {
        _msgs.add(
          TextInfo(
              name: name, message: message, sender: sender, date: Timestamp()),
        );
        _textEditingController.text = "";
      });
    }
    if (message != "") {
      String answer = await transferKnowledge(message);
      setState(() {
        _msgs.add(
          TextInfoBot(message: answer, date: Timestamp()),
        );
      });
    }
    _autoScrollController.animateToAnchor;
    _focusNode.requestFocus();
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
          print(message['message_id']);

          updateUserMsgs(message['email'], message['message'], 'user',
              message['message_created_at']);

          updateBotMsgs(message['response'], message['response_created_at']);
          _autoScrollController.animateToAnchor;
        }
      }

      //goAhead(handshakeResult);
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
    _autoScrollController.animateToAnchor;
  }

  void updateUserMsgs(name, message, sender, date) async {
    Timestamp stamp = _timestampTemppu(date);
    setState(() {
      _msgs.add(
        TextInfo(name: name, message: message, sender: sender, date: stamp),
      );
    });
    _autoScrollController.animateToAnchor;
  }

  @override
  void initState() {
    super.initState();
    _initMessages();
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
          height: 75,
          child: Column(
            children: [
              const SizedBox(height: 3),
              Row(
                children: [
                  GestureDetector(
                    onLongPress: () {},
                    child: PopupMenuButton<NewChatMenu>(
                      onSelected: (value) {
                        switch (value) {
                          case NewChatMenu.newChat:
                            print('clear the chat');
                            break;
                          case NewChatMenu.email:
                            print('email the stuff');
                            break;
                          default:
                        }
                      },
                      icon: Icon(Icons.new_label,
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
                            return myButtonBackgroundColor;
                          },
                        ),
                      ),
                      onPressed: () {
                        _addMessage(
                          "Jarkko",
                          _textEditingController.text,
                          'user',
                        );
                        _textEditingController.clear();
                      },
                      child: const Text('Kysy'),
                    ),
                  ),
                ],
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
                      width: 300,
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
                              Styles.backgroundGray,
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
