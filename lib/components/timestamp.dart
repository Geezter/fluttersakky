import 'package:flutter/material.dart';

var timestamp = DateTime.now().millisecondsSinceEpoch;
var tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
//String datetime = tsdate.hour.toString() + "/" + tsdate.minute.toString() + "/" + tsdate.day.toString();

class Timestamp extends StatelessWidget {
  Timestamp({super.key});

  String datetime = tsdate.hour.toString() +
      ":" +
      tsdate.minute.toString() +
      ":" +
      tsdate.second.toString();
  

  @override
  Widget build(BuildContext context) {
    return Text(datetime);
  }
}
