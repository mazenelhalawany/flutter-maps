import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.photo});

  final String photo;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      photo,
      // fit: BoxFit.cover,
      //  height: 348.h,
      width: 440,
    );
  }
}
