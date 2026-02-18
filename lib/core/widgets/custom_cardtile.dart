import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../utils/progresscolor.dart';

class CustomCardTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final Color? color;
  final Color? textColor;
  final String? imageUrl;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? progresscolor;
  final String? status; // ✅ جديد
  final String value;
  final String groupvalue;
  final ValueChanged<String>? onChanged;
  final bool needRadio;

  const CustomCardTile(
      {super.key,
      required this.title,
      this.subtitle,
      this.icon,
      this.color,
      this.textColor,
      this.imageUrl,
      this.onTap,
      this.width,
      this.height,
      this.progresscolor,
      this.status,
      required this.value,
      required this.groupvalue,
      this.onChanged,
      this.needRadio = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged!(value); // لما تضغط على أي مكان على الويدجت
      },
      child: Card(
        elevation: 3,
        color: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: width ?? double.infinity,
          // height: height ?? 80,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (imageUrl != null)
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      imageUrl!,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor ?? Colors.black,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: TextStyle(
                              color: textColor ?? Colors.black,
                              fontSize: 14,
                              fontWeight: AppFonts.light),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                needRadio
                    ? Radio(
                        activeColor: AppColors.backgroundcolor,
                        value: value,
                        groupValue: groupvalue,
                        onChanged: (value) {
                          if (value != null) {
                            onChanged?.call(value); // 👈 بعث القيمة لبرا
                          }
                        },
                      )
                    : const Text("default")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
