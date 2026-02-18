import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    this.textInputType,
    super.key,
    required this.labelText,
    this.isSecure = false,
    this.customTextController,
  });
  final String labelText;
  final bool isSecure;
  final TextEditingController? customTextController;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: TextField(
            keyboardType: textInputType,
            style: const TextStyle(color: Colors.white),
            controller: customTextController,
            obscureText: isSecure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              labelStyle: const TextStyle(color: Colors.white),
              fillColor: AppColors.blue,
              filled: true,
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              ),
            )),
      ),
    );
  }
}
