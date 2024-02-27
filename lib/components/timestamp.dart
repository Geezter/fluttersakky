import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<String> getDate(time) async {
  initializeDateFormatting('fi_FI');
  Intl.defaultLocale = 'fi';
  DateTime timestamp = DateTime.now().toLocal();
  if (time != null) {
    timestamp = time;
  }

  String formattedDate =
      DateFormat('EEE d MMM kk:mm:ss', 'fi_FI').format(timestamp);
  print(formattedDate);
  return formattedDate;
}

class Timestamp extends StatelessWidget {
  Timestamp({this.time, super.key});

  final DateTime? time;
  DateTime? newTime;

  @override
  Widget build(BuildContext context) {
    if (time != null) {
      newTime = time?.add(const Duration(hours: 4));
    }
    return FutureBuilder<String>(
      future: getDate(newTime),
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? "",
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 70, 70, 70),
            fontWeight: FontWeight.w300,
          ),
        );
      },
    );
  }
}
