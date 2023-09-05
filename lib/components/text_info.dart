import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  TextInfo(this.name, this.position, {super.key});

  final String name;
  final String position;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center{$position},
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        width: 300,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 53, 134, 254),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text('12.03'),
              (position == 'Right')
                  ? const Spacer()
                  : const SizedBox(
                      width: 8,
                    ),
              Text(name),
              (position == 'Left')
                  ? const Spacer()
                  : const SizedBox(
                      width: 8,
                    ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu_open_sharp, size: 15),
              ),
            ],
          )),
    );
  }
}
