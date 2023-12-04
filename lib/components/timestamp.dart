import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<String> getDate() async {
  initializeDateFormatting('fi_FI');
  Intl.defaultLocale = 'fi';
  var timestamp = DateTime.now().toLocal();
  String formattedDate = DateFormat('EEE d MMM kk:mm:ss', 'fi_FI').format(timestamp);
  print(formattedDate);
  return formattedDate;
}

class Timestamp extends StatelessWidget {
  const Timestamp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDate(),
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? "",
          style: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 70, 70, 70),
            fontWeight: FontWeight.w300,
          ),
        );
      },
    );
  }
}
