import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14.0,
    this.color = AppColors.boldtextcolor,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      textScaler: const TextScaler.linear(1.0),
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
