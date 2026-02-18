// import 'package:flutter/material.dart';
// import 'sharedpreferences.dart';
// import '../../../features/auth/view/login_view.dart';
// import '../../../root.dart';

// class AuthCheck {
//   static Future<void> navigate(BuildContext context) async {
//     final token = await CacheHelper.getData(key: 'token');

//     if (!context.mounted) return;

//     if (token == "guest") {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const Root()));
//     } else if (token == null || token.isEmpty) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const LoginView()));
//     } else {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const Root()));
//     }
//   }
// }
