import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/style/styles.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key,
      required this.myIcon,
      required this.myTitle,
      required this.myHelperText,
      required this.myType});

  final String myTitle;
  final IconData myIcon;
  final String myHelperText;
  final double itemSize = 25;
  final TextInputType myType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Styles.botGray,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            myIcon,
            size: 35,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              child: TextField(
                keyboardType: myType,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  label: Text(myHelperText),
                  hintText: myTitle,
                  
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
