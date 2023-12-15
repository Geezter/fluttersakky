import 'package:flutter/material.dart';
import 'package:kouluharjoittelu/style/styles.dart';

class ProfileItem extends StatefulWidget {
  const ProfileItem({
    super.key,
    required this.myIcon,
    required this.myTitle,
  });

  final String myTitle;
  final IconData myIcon;

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  final TextEditingController _textEditingController = TextEditingController();
  final double itemSize = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Styles.botGray,
        //borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.myIcon,
            size: itemSize,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 32,
              child: TextFormField(
                controller: _textEditingController,
                onChanged: (value) {
                  _textEditingController.text = value;
                },
                //initialValue: widget.myTitle,
                style: TextStyle(
                    fontSize: itemSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            //height: 26,
            //width: 24,
            child: IconButton(
              alignment: Alignment.centerRight,
              iconSize: itemSize,
              onPressed: () {
                print('you pressed the button you sick fuck');
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: itemSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
