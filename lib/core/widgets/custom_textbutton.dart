import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

Widget textbutton({required Function() onPressed, required String text}) {
  return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: AppFonts.regular,
            fontSize: 14,
            color: AppColors.backgroundcolor),
      ));
}
