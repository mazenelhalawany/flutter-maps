// import 'package:flutter/material.dart';
// import 'package:flutter_hungry_app/core/constants/colors.dart';
// import 'package:flutter_hungry_app/core/constants/fonts.dart';
// import 'package:flutter_hungry_app/core/utils/navigation.dart';
// import 'package:flutter_hungry_app/core/widgets/custom_button.dart';
// import 'package:flutter_hungry_app/features/auth/view/splash_view.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomCard extends StatelessWidget {
//   const CustomCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.cardColor,
//     required this.iconColor,
//     this.width,
//     this.height,
//     this.titlesize,
//     this.descriptionsize,
//     this.sizedbox,
//     this.needButton = false,
//     this.isBlack=false,
//   });
//   final String title;
//   final String description;
//   final Widget?
//       icon; // 👈 هنا بدل IconData أو Icon خلتها Widget عشان أقبل أي نوع
//   final double? width;
//   final double? height;
//   final Color cardColor;
//   final bool isBlack;
//   final Color? iconColor;
//   final double? titlesize;
//   final double? descriptionsize;
//   final double? sizedbox;
//   final bool? needButton;

//   @override
//   Widget build(BuildContext context) {
//   //  final cubit = TasksCubit.get(context);

//     return Card(
//       color: cardColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30.0.r),
//       ),
//       elevation: 5,
//       child: Container(
//         width: width ?? 235.w,
//         height: height ?? 90.w,
//         padding: const EdgeInsets.symmetric(
//           vertical: 15.0,
//           horizontal: 22.0,
//         ).w,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: AppColors.backgroundcolor,
//                     fontSize: titlesize ?? 14.sp,
//                     fontWeight: AppFonts.regular,
//                   ),
//                 ),
//                 if (icon != null) icon!, // 👈 لو الأيقونة موجودة، اعرضها
//               ],
//             ),
//             SizedBox(height: sizedbox ?? 5),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     description,
//                     style: TextStyle(
//                       color: isBlack? AppColors.backgroundcolor:AppColors.boldtextcolor,
//                       fontSize: descriptionsize ?? 12.sp,
//                       fontWeight: AppFonts.light,
//                     ),
//                   ),
//                 ),
//                 if (needButton == true)
//                   Expanded(
//                     child: CustomButton(
//                       buttoncolor: AppColors.backgroundcolor,
//                       textcolor: AppColors.maincolor,
//                       onPressed: () {
//                         AppNavigationType.navigate(
//                           context,
//                           page: const SplashScreen(),
//                           type: AppNavigation.pushReplacement,
//                         );
//                       },
//                       text: "view Tasks",
//                     ),
//                   )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_testmaps/core/constants/colors.dart';
import 'package:flutter_application_testmaps/core/constants/pictures.dart';
import 'package:flutter_application_testmaps/core/widgets/customtext.dart';

class CustomPhotoCard extends StatelessWidget {
  const CustomPhotoCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.text,
    required this.rating,
  });

  final String image; // asset أو network
  final String title;
  final String description;
  final Color backgroundColor;
  final String text;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      //width: 180.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 30,
                right: 0,
                left: 0,
                child: Image.asset(AppImages.shadow),
              ),
              image.isEmpty
                  ? Container(
                      height: 140,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    )
                  : Image.network(
                      fit: BoxFit.contain, // ✅ مهم
                      image,
                      height: 200,
                      width: double.infinity,
                      // fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 5),

                /// DESCRIPTION
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            text: rating,
                            color: AppColors.boldtextcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.suit_heart,
                        color: AppColors.boldtextcolor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
