import 'package:flutter/material.dart';

class InputItem extends StatelessWidget {
  InputItem({Key? key, required this.mText, required this.ics})
      : super(key: key);
  final mText;
  final ics;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 1, 10, 2),
      child: TextField(
        decoration: InputDecoration(
            label: Row(
              children: [
                Icon(ics),
                const SizedBox(
                  width: 5,
                ),
                Text(mText)
              ],
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
