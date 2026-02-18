import 'package:flutter/material.dart';
import '../constants/colors.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    splashColor: Colors.transparent, //for bottom navigation bar
    fontFamily: 'Poppins',
    colorScheme: AppColors.lightTheme,
    scaffoldBackgroundColor: AppColors.backgroundcolor,
    brightness: Brightness.light,
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  );

  static final darkTheme = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: AppColors.darkTheme,
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
