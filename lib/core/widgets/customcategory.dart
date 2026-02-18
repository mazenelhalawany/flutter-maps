import 'package:flutter/material.dart';

import 'customtext.dart';

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
  });
  final String text;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: CustomText(
          text: text,
          color: textColor,
        ));
  }
}
