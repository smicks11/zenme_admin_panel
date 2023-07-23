import 'resources.dart';
import 'package:flutter/material.dart';

import 'app_textstyle.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.text,
      this.press,
      this.color = kPrimaryColor,
      this.padding = const EdgeInsets.all(kPad * 0.75),
      this.width, this.height = 50, this.textColor,
      this.textSize = 12
      })
      : super(key: key);

  final Widget text;
  final VoidCallback? press;
  final Color color;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final Color? textColor;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(2)),
          //flatbutton changed
      child: TextButton(
        onPressed: press,
        child: text,
        // child: Text(
        //   text,
        //   style:  labelText(context).copyWith(color: kWhiteColor, fontSize: 14),
        // ),
      ),
    );
  }
}


class ShowLoaderButton extends StatelessWidget {
  const ShowLoaderButton(
      {Key? key,
      required this.press,
      this.color = kPrimaryColor,
      this.padding = const EdgeInsets.all(kPad * 0.75),
      this.width, this.textColor, required this.placeHolder
      })
      : super(key: key);

  final VoidCallback press;
  final Color color;
  final EdgeInsets padding;
  final double? width;
  final Color? textColor;
  final Widget placeHolder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(2)),
          //flatbutton changed
      child: TextButton(
        onPressed: press,
        child: placeHolder
      ),
    );
  }
}