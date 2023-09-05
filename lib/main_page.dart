import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/components/text_info.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 60),
      decoration: const BoxDecoration(
          gradient: RadialGradient(colors: [
        Color.fromARGB(221, 0, 35, 131),
        Color.fromARGB(189, 0, 10, 94)
      ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            TextInfo('Tässä on kirjoitusta', 'Left',),
            TextInfo('Mitäs mieltä olet tästä?', 'Right')

          ],
          
          ),
          Column(children: [
            TextFormField(

              onChanged: (value) {
                
              },
            )
          ],)
        ],
      )
    );
  }
}
