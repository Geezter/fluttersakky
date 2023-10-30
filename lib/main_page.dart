import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/chat_box.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController _scrollController = ScrollController();

  @override
  build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 37, 108),
        title: const Text('The Subtle Gentlebot'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: const ChatBox(),
          ),
        );
      }),
    );
  }
}
