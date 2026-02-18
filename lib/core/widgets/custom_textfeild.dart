// import 'package:flutter/material.dart';
// import '../constants/colors.dart';
// import '../constants/fonts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTextField extends StatelessWidget {
//   const CustomTextField(
//       {super.key,
//       required this.hintText,
//       required this.controller,
//       required this.suffixIcon,
//       required this.prefixIcon,
//       required this.obscureText,
//       this.validator,
//       this.readonly = false,
//       this.ontap,
//       this.elevation,
//       this.fillColor = AppColors.backgroundcolor,
//       this.onChanged});
//   final String hintText;
//   final TextEditingController? controller;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final bool obscureText;
//   final String? Function(String?)? validator;
//   final bool readonly;
//   final double? elevation;
//   final Function()? ontap;
//   final Color fillColor;
//   final Function(String)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 59.h,
//       margin: EdgeInsets.symmetric(horizontal: 22.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Material(
//             borderRadius: BorderRadius.circular(15.r),
//             elevation: elevation ?? 0,
//             shadowColor: Colors.black.withOpacity(0.4),
//             color: Colors.transparent,
//             child: TextFormField(
//               onChanged: onChanged,
//               onTap: ontap,
//               readOnly: readonly,
//               validator: validator,
//               obscureText: obscureText,
//               controller: controller,
//               style: TextStyle(
//                   color: AppColors.boldtextcolor,
//                   fontSize: 14.sp,
//                   fontWeight: AppFonts.light),
//               decoration: InputDecoration(
//                 errorStyle: TextStyle(
//                   fontSize: 12.sp,
//                   color: AppColors.red,
//                   height: 1.2,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(
//                     vertical: 24.h), // يشيل أي padding داخلي
//                 isDense: true, // يمنع الزيادات
//                 prefixIconConstraints: BoxConstraints(
//                   minWidth: 10.w,
//                   minHeight: 10.h,
//                   maxWidth: 40,
//                   maxHeight: 40,
//                 ),
//                 suffixIconConstraints: BoxConstraints(
//                   minWidth: 10.w,
//                   minHeight: 10.h,
//                   maxWidth: 40,
//                   maxHeight: 40,
//                 ),

//                 // contentPadding: EdgeInsets.symmetric(

//                 //   vertical: 0.h, // هنا بيتحدد ارتفاع الـ TextField
//                 // ),

//                 // ✅ فقط لو في أيقونة نستخدم Center(child: icon)
//                 prefixIcon: prefixIcon != null
//                     ? Center(child: prefixIcon)
//                     : const Padding(padding: EdgeInsets.only(left: 5)),
//                 suffixIcon:
//                     suffixIcon != null ? Center(child: suffixIcon) : null,
//                 prefixStyle: const TextStyle(
//                   color: AppColors.boldtextcolor,
//                 ),

//                 filled: true,
//                 fillColor: fillColor,
//                 border: customBorder(),
//                 enabledBorder: customBorder(),
//                 focusedBorder: customBorder(customcolor: Colors.black),
//                 errorBorder: customBorder(customcolor: AppColors.red),
//                 focusedErrorBorder: customBorder(customcolor: AppColors.red),
//                 hintText: hintText,
//                 hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: AppColors.lighttextcolor,
//                     fontWeight: AppFonts.light),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// OutlineInputBorder customBorder(
//         {Color customcolor = AppColors.backgroundcolor}) =>
//     OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15.r),
//         borderSide: BorderSide(color: customcolor));

// // import 'package:flutter/material.dart';
// // import 'package:flutter_hungry_app/core/constants/colors.dart';
// // import 'package:flutter_hungry_app/core/constants/fonts.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class CustomTextField extends StatelessWidget {
// //   const CustomTextField({
// //     super.key,
// //     required this.hintText,
// //     required this.controller,
// //     required this.suffixIcon,
// //     required this.prefixIcon,
// //     required this.obscureText,
// //     this.validator,
// //     this.readonly = false,
// //     this.ontap,
// //     this.elevation,
// //   });

// //   final String hintText;
// //   final TextEditingController? controller;
// //   final Widget? prefixIcon;
// //   final Widget? suffixIcon;
// //   final bool obscureText;
// //   final String? Function(String?)? validator;
// //   final bool readonly;
// //   final double? elevation;
// //   final Function()? ontap;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: 22.w),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Material(
// //             elevation: elevation ?? 0,
// //             shadowColor: Colors.black.withOpacity(0.4),
// //             borderRadius: BorderRadius.circular(15.r),
// //             color: Colors.transparent,
// //             child: TextFormField(
// //               onTap: ontap,
// //               readOnly: readonly,
// //               validator: validator,
// //               obscureText: obscureText,
// //               controller: controller,
// //               // التأكد من أن النص يبدأ من المنتصف رأسياً
// //               textAlignVertical: TextAlignVertical.center,
// //               style: TextStyle(
// //                 color: AppColors.boldtextcolor,
// //                 fontSize: 14.sp,
// //                 fontWeight: AppFonts.light,
// //               ),
// //               decoration: InputDecoration(
// //                 errorStyle: TextStyle(
// //                   fontSize: 12.sp,
// //                   color: AppColors.red,
// //                   height: 1.2,
// //                 ),

// //                 // تم تعديل الـ padding ليعطي مساحة للكتابة
// //                 contentPadding:
// //                     EdgeInsets.symmetric(vertical: 22.h, horizontal: 16.w),
// //                 isDense: true,

// //                 // تحسين قيود الأيقونات لإبعادها عن النص
// //                 prefixIconConstraints: BoxConstraints(
// //                   minWidth: 45.w, // مساحة كافية للأيقونة
// //                 ),
// //                 suffixIconConstraints: BoxConstraints(
// //                   minWidth: 45.w,
// //                 ),

// //                 // شيلنا الـ Center واستبدلناه بالأيقونة مباشرة أو Padding
// //                 prefixIcon: prefixIcon != null
// //                     ? Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 8.w),
// //                         child: prefixIcon,
// //                       )
// //                     : null,
// //                 suffixIcon: suffixIcon != null
// //                     ? Padding(
// //                         padding: EdgeInsets.symmetric(horizontal: 8.w),
// //                         child: suffixIcon,
// //                       )
// //                     : null,

// //                 filled: true,
// //                 fillColor: AppColors.backgroundcolor,

// //                 border: customBorder(),
// //                 enabledBorder: customBorder(),
// //                 focusedBorder: customBorder(customcolor: AppColors.maincolor),
// //                 errorBorder: customBorder(customcolor: AppColors.red),
// //                 focusedErrorBorder: customBorder(customcolor: AppColors.red),

// //                 hintText: hintText,
// //                 hintStyle: TextStyle(
// //                   fontSize: 14.sp,
// //                   color: AppColors.lighttextcolor,
// //                   fontWeight: AppFonts.light,
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // OutlineInputBorder customBorder(
// //         {Color customcolor = AppColors.backgroundcolor}) =>
// //     OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(15.r),
// //       borderSide: BorderSide(color: customcolor),
// //     );
