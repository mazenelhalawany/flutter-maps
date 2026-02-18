import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import 'customtext.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.widget,
      this.buttoncolor,
      this.textcolor,
      this.width});
  final VoidCallback? onPressed;
  final Widget widget;
  final Color? buttoncolor;
  final Color? textcolor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.blue)),
        width: width ?? double.infinity,
        // height: 48.h,
        margin: const EdgeInsets.symmetric(horizontal: 22),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 25),
              shadowColor: AppColors.blue,
              elevation: 10,
              backgroundColor: buttoncolor ?? AppColors.backgroundcolor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)))),
          onPressed: onPressed,
          child: widget,
        ));
  }
}
