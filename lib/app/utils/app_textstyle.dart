// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'resources.dart';

/// App TextStyles
TextStyle heading1(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

TextStyle heading2(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );

TextStyle heading3(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

TextStyle bodyNormalText(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

TextStyle bodySmallText(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 12,
    );

TextStyle bodyTinyText(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 8,
      fontWeight: FontWeight.w400,
    );

TextStyle labelText(BuildContext context) => TextStyle(
      color: kTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

TextStyle planlistText(BuildContext context) => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: kTextColor,
    );
