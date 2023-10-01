import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/text_info.dart';
import 'package:kouluharjoittelu/config/api.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _textEditingController = TextEditingController();
  String _inputMessage = "";
  final List _msgs = [];

  @override
  Widget build(BuildContext context) {
    Future<String> transferKnowledge(message) async {
      String gptAnswer = await doShit(message);
      return gptAnswer;
    }

    void _addmessage(name, message, sender) async {
      setState(() {
        _msgs.add(
          TextInfo(
            name: name,
            message: message,
            sender: sender,
          ),
        );

      });
      String answer = await transferKnowledge(message);

      setState(() {
        _msgs.add(
          TextInfoBot(
            message: answer,
          ),
        );
      });
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
      decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [
        Color.fromARGB(137, 22, 0, 217),
        Color.fromARGB(255, 0, 2, 23)
      ])),
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
                    hintText: 'Kysy jottain.. ',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  controller: _textEditingController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    _inputMessage = value;
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    _addmessage(
                        "Jarkko", _inputMessage, 'user');
                    _textEditingController.clear();
                  },
                  child: const Text('Kysy'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
