// ignore_for_file: prefer_const_constructors
import 'resources.dart';
import 'package:flutter/material.dart';

class FormBuild extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  // final On? onChanged;
  final String errorText;
  final Function(dynamic)? onChanged;
  final FormFieldValidator validator;
  // final bool autoFocus;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusederrorBorder;
  final TextInputAction? textInputAction;
  final TextInputType keyType;
  final int? maxLines;

  const FormBuild(
      {Key? key,
      this.maxLines,
      required this.controller,
      required this.labelText,
      required this.icon,
      required this.validator,
      // this.autoFocus = false,
      this.onChanged,
      String? errorText,
      this.enabledBorder,
      this.focusedBorder,
      this.errorBorder,
      this.focusederrorBorder,
      TextInputType? keyType, this.textInputAction})
      : errorText = errorText ?? "",
        keyType = keyType ?? TextInputType.emailAddress,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      // autofocus: autoFocus,
      validator: validator,
      style: TextStyle(
        color: kBlackColor,
        fontSize: 14
      ),
      textInputAction: textInputAction,
      keyboardType: keyType,
      controller: controller,
      decoration: InputDecoration(
        errorText: errorText,
        suffixIcon: controller.text.length != null
            ? Padding(
                padding: EdgeInsets.all(kPad - 5),
                child: GestureDetector(
                  onTap: () => controller.clear(),
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: Icon(
                        icon,
                        size: 8,
                        color: Colors.black,
                      )),
                ),
              )
            : null,
        hintStyle: TextStyle(
            fontSize: 13, color: Colors.black45),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPad - 10),
            borderSide: BorderSide(color: kTextFieldFillColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPad - 10),
            borderSide: BorderSide(color: kPrimaryColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPad - 10),
            borderSide: BorderSide(color: kPrimaryColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kPad - 10),
            borderSide: BorderSide(color: kTextFieldFillColor)),
        hintText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
