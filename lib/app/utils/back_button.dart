// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'resources.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Padding(
        padding: EdgeInsets.all(kPad - 3),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            // height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1,
                color: kBlackColor
              ),
              borderRadius: BorderRadius.circular(kPad / 4)
            ),
            child: Icon(Icons.arrow_back, size: 16, color: kBlackColor,),
          ),
        ),
      ),
    );
  }
}