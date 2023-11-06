import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key, required this.myIcon, required this.myTitle});

  final String myTitle;
  final IconData myIcon;
  final double itemSize = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: const BoxDecoration(
          color: Color.fromARGB(53, 107, 23, 122),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            myIcon,
            size: itemSize,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            myTitle,
            style: TextStyle(
              fontSize: itemSize,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 20,
            child: IconButton(
              alignment: Alignment.centerRight,
              iconSize: itemSize,
              onPressed: () {
                print('you pressed the button you sick fuck');
              },
              icon: Icon(Icons.edit,
              color: Colors.white,
              size: itemSize,
              ),
            ),
          )
        ],
      ),
    );
  }
}
