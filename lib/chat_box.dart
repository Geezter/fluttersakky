import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/my_appBar.dart';
import 'package:kouluharjoittelu/components/text_info.dart';
import 'package:kouluharjoittelu/config/api.dart';
import 'package:kouluharjoittelu/style/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:kouluharjoittelu/components/timestamp.dart';
import 'package:auto_scroll/auto_scroll.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final List _msgs = [];
  late Map<String, dynamic> messagesResult;

  Future<String> transferKnowledge(message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    String gptAnswer = await askChatAPI(token, message);
    return gptAnswer;
  }

  _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _addmessage(name, message, sender) async {
    if (message != "") {
      setState(() {
        _msgs.add(
          TextInfo(
              name: name,
              message: message,
              sender: sender,
              date: Timestamp()),
        );
        _textEditingController.text = "";
      });
      _scrollToEnd();
    }
    if (message != "") {
      String answer = await transferKnowledge(message);
      setState(() {
        _msgs.add(
          TextInfoBot(
            message: answer,
            date: Timestamp()),
        );
      });
    }
    _focusNode.requestFocus();
  }

  Future<void> _initMessages() async {
    print('in initmessages');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('token', '');
    final String? token = prefs.getString('token');
    if (token != null && token != 'token') {
      var result = await getMessages(token);
      messagesResult = convert.jsonDecode(result);
      //print(messagesResult);
      for (dynamic message in messagesResult['rows']) {
        print(message['message_id']);

        //print(message[1]);
        updateUserMsgs(message['email'], message['message'], 'user',
            message['message_created_at']);

        updateBotMsgs(message['response'], message['response_created_at']);
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
    _initMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(s: 'Botti'),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 60),
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  tileMode: TileMode.mirror,
                  colors: [
                    Color.fromARGB(255, 230, 232, 250),
                    Color.fromARGB(255, 230, 232, 250)
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ), // Set your desired color
                            ),
                            hintText: 'Mikä askarruttaa?',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70)),
                          ),
                          controller: _textEditingController,
                          focusNode: _focusNode,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onChanged: (value) {
                            _textEditingController.text = value;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
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
                            _addmessage(
                                "Jarkko", _textEditingController.text, 'user');
                            _textEditingController.clear();
                          },
                          child: const Text(
                            'Kysy',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
