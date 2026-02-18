import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color blue = Color(0xFF0666EB);
  static const Color lightBlue = Color(0xFFE5EFFD);
  static const Color lightGray = Color(0xFFE1E1E1);
  static const Color lighttextcolor = Color(0xFF6A6A6A);
  static const Color boldtextcolor = Color(0xFF3C2F2F);
  static const Color backgroundcolor = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFF44336);
  static ColorScheme lightTheme = ColorScheme.fromSeed(seedColor: blue);
  static const Color foodCard = Color(0xFF3C2F2F);
  static ColorScheme darkTheme = const ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
  );
}
