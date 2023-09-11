import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/text_info.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final Alignment leftAlignment = Alignment.centerLeft;
  final Alignment rightAlignment = Alignment.centerRight;
  String _inputMessage = "";
  final List<TextInfo> _msgs = [];

  @override
  Widget build(BuildContext context) {

    void _addmessage(alignment, name, message, sender) {
      setState(() {
        _msgs.add(TextInfo(
          alignment: alignment,
          name: name,
          message: message,
          sender: sender,
        )
        
        );
        
      });
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
      decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [
        Color.fromARGB(221, 0, 35, 131),
        Color.fromARGB(189, 0, 10, 94)
      ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ..._msgs,
            ],
          ),
          Column(
            children: [
              TextFormField(
                controller: _textEditingController,
                onChanged: (value) {
                  _inputMessage = value;
                },
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () {
                        _addmessage(rightAlignment, "Jarkko", _inputMessage, 'user');
                        _textEditingController.clear();
                      },
                      child: const Text('Lähetä'))),
            ],
          )
        ],
      ),
    );
  }
}
