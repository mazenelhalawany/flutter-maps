// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'core/services/api_service.dart';
// // import 'core/services/dio.dart';
// // import 'core/widgets/bottomnavigation.dart';
// // import 'features/auth/view/profile_view.dart';
// // import 'features/home/cubit/navigationcubit.dart';
// // import 'features/home/data/repository/home_repository_implement.dart';
// // import 'features/productdetails/views/productdetails.dart';
// // import 'features/home/cubit/home_cubit.dart';
// // import 'features/home/cubit/home_state.dart';
// // import 'features/home/views/home.dart';
// // import 'features/orderhistory/view/orderhistory.dart';
// // import 'features/Cart/views/cart.dart';
// // import 'features/profile/view/profileview.dart';

// // class Root extends StatefulWidget {
// //   const Root({super.key});

// //   @override
// //   State<Root> createState() => _RootState();
// // }

// // class _RootState extends State<Root> {
// //   DateTime? lastBackPressed;
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (_) => NavigationCubit(),
// //       child: BlocBuilder<NavigationCubit, int>(
// //         builder: (context, state) {
// //           final cubit = NavigationCubit.get(context);
// //           return WillPopScope(
// //             onWillPop: () async {
// //               final now = DateTime.now();

// //               if (lastBackPressed == null ||
// //                   now.difference(lastBackPressed!) >
// //                       const Duration(seconds: 2)) {
// //                 lastBackPressed = now;

// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(
// //                     content: Text("Press back again to exit"),
// //                     duration: Duration(seconds: 2),
// //                   ),
// //                 );
// //                 return false; // ما يخرجش دلوقتي
// //               }
// //               return true; // يخرج لو ضغط مرة تانية
// //             },
// //             child: Scaffold(
// //               body: IndexedStack(
// //                 index: state,
// //                 children: const [
// //                   Home(),
// //                   Cart(),
// //                   Orderhistory(),
// //                   ProfileView(),
// //                 ],
// //               ),
// //               bottomNavigationBar: CustomNavigationbar(
// //                 ontap: cubit.changePage,
// //                 index: state,
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'core/services/api_service.dart';
// import 'core/services/dio.dart';
// import 'core/widgets/bottomnavigation.dart';
// import 'features/auth/view/profile_view.dart';
// import 'features/home/cubit/navigationcubit.dart';
// import 'features/home/data/repository/home_repository_implement.dart';
// import 'features/productdetails/views/productdetails.dart';
// import 'features/home/cubit/home_cubit.dart';
// import 'features/home/cubit/home_state.dart';
// import 'features/home/views/home.dart';
// import 'features/orderhistory/view/orderhistory.dart';
// import 'features/Cart/views/cart.dart';
// import 'features/profile/view/profileview.dart';

// class Root extends StatefulWidget {
//   const Root({super.key});

//   @override
//   State<Root> createState() => _RootState();
// }

// class _RootState extends State<Root> {
//   DateTime? _lastBackPressed;

//   Future<bool> _onWillPop() async {
//     final now = DateTime.now();

//     // Check if this is the first back press or if more than 2 seconds have passed
//     if (_lastBackPressed == null ||
//         now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
//       // First back press or timeout - save the time and show message
//       _lastBackPressed = now;

//       // Show a snackbar to inform user
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Press back again to exit'),
//           duration: Duration(seconds: 2),
//           behavior: SnackBarBehavior.floating,
//         ),
//       );

//       return false; // Don't exit
//     }

//     // Second back press within 2 seconds - exit the app
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => NavigationCubit(),
//       child: PopScope(
//         canPop: false,
//         onPopInvokedWithResult: (didPop, result) async {
//           if (didPop) return;

//           final shouldPop = await _onWillPop();
//           if (shouldPop && context.mounted) {
//             SystemNavigator.pop();
//           }
//         },
//         child: BlocBuilder<NavigationCubit, int>(
//           builder: (context, state) {
//             final cubit = NavigationCubit.get(context);
//             return Scaffold(
//               body: IndexedStack(
//                 index: state,
//                 children: const [
//                   Home(),
//                   Cart(),
//                   Orderhistory(),
//                   ProfileView(),
//                 ],
//               ),
//               bottomNavigationBar: CustomNavigationbar(
//                 ontap: cubit.changePage,
//                 index: state,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
