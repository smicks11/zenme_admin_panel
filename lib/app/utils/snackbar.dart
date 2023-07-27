import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart'; 
import 'app_colors.dart';
import 'app_textstyle.dart';

cToast(
    {required String msg,
    required Color color,
    required BuildContext context}) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      iconPositionLeft: 8,
      textStyle: bodySmallText(context).copyWith(color: kWhiteColor),
      message: msg,
      backgroundColor: color,
      icon: const Icon(EvaIcons.infoOutline, color: kWhiteColor),
    ),
  );
}