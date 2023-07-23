import 'resources.dart';
import 'package:flutter/material.dart';

import 'app_textstyle.dart';

class OtherPrimaryButton extends StatelessWidget {
  const OtherPrimaryButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color = kPrimaryColor,
      this.padding = const EdgeInsets.all(kPad * 0.75),
      this.width,
      this.textColor})
      : super(key: key);

  final String text;
  final VoidCallback press;
  final Color color;
  final EdgeInsets padding;
  final double? width;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(kPad)),
      //flatbutton changed
      child: TextButton(
        onPressed: press,
        child: Text(
          text,
          style: labelText(context),
        ),
      ),
    );
  }
}
