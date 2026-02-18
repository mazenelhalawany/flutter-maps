// // import 'dart:developer';

// // import 'package:dio/dio.dart';
// // import 'package:flutter_hungry_app/core/constants/api_end_points.dart';
// // import 'package:flutter_hungry_app/features/auth/cubit/profile_cubit.dart';
// // import 'package:path/path.dart';

// // class PaymobManager {
// //   Dio dio = Dio(LogInterceptor(
// //     requestBody: true,
// //     responseBody: true,
// //   ) as BaseOptions?);
// //   Future<String?> getAuthToken() async {
// //     try {
// //       final response = await dio.post(
// //         'https://accept.paymob.com/api/auth/tokens',
// //         data: {
// //           "api_key": Constatns.apiKey,
// //         },
// //       );

// //       if (response.statusCode == 201 || response.statusCode == 200) {
// //         return response.data['token'];
// //       } else {
// //         return null;
// //       }
// //     } catch (e) {
// //       print(e.toString());
// //     }
// //     return null;
// //   }

// //   Future<String?> createOrder(
// //       String authToken, String amountCents, String currency) async {
// //     try {
// //       final response = await dio.post(
// //         'https://accept.paymob.com/api/ecommerce/orders',
// //         data: {
// //           "auth_token": authToken,
// //           "delivery_needed": "true",
// //           "amount_cents": amountCents,
// //           "currency": currency,
// //           "items": []
// //         },
// //       );

// //       if (response.statusCode == 201 || response.statusCode == 200) {
// //         return response.data['id'].toString();
// //       } else {
// //         return null;
// //       }
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //     return null;
// //   }

// //   Future<String?> getPaymentKey(String authToken, String amountCents,
// //       String currency, String orderId, Map<String, dynamic> billingData) async {
// //     try {
// //       final response = await dio.post(
// //         'https://accept.paymob.com/api/acceptance/payment_keys',
// //         data: {
// //           "auth_token": authToken,
// //           "amount_cents": amountCents,
// //           "currency": currency,
// //           "order_id": orderId,
// //           "billing_data": billingData,
// //           "integration_id": Constatns
// //               .integrationId, // Replace with your actual integration ID
// //         },
// //       );

// //       if (response.statusCode == 201 || response.statusCode == 200) {
// //         return response.data['token'];
// //       } else {
// //         return null;
// //       }
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //     return null;
// //   }
// // }
// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter_hungry_app/core/constants/api_end_points.dart';

// class PaymobManager {
//   late final Dio dio;

//   PaymobManager() {
//     dio = Dio(
//       BaseOptions(
//         connectTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//       ),
//     )..interceptors.add(
//         LogInterceptor(
//           requestBody: true,
//           responseBody: true,
//           requestHeader: true,
//           responseHeader: true,
//         ),
//       );
//   }

//   Future<String?> getAuthToken() async {
//     try {
//       final data = {"api_key": Constatns.apiKey};
//       log("Requesting Auth Token with data: $data");

//       final response = await dio.post(
//         'https://accept.paymob.com/api/auth/tokens',
//         data: data,
//       );

//       log("Auth Token Response: ${response.data}");
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data['token'];
//       }
//     } catch (e) {
//       log("getAuthToken Error: $e");
//     }
//     return null;
//   }

//   Future<String?> createOrder(
//       String authToken, String amountCents, String currency) async {
//     try {
//       final data = {
//         "auth_token": authToken,
//         "delivery_needed": "false",
//         "amount_cents": amountCents,
//         "currency": currency,
//         "items": []
//       };

//       log("Creating Order with data: $data");
//       final response = await dio.post(
//         'https://accept.paymob.com/api/ecommerce/orders',
//         data: data,
//       );

//       log("Create Order Response: ${response.data}");
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data['id'].toString();
//       }
//     } catch (e) {
//       log("createOrder Error: $e");
//     }
//     return null;
//   }

//   Future<String?> getPaymentKey(String authToken, String amountCents,
//       String currency, String orderId, Map<String, dynamic> billingData) async {
//     try {
//       // final data = {
//       //   "auth_token": authToken,
//       //   "amount_cents": amountCents,
//       //   "currency": currency,
//       //   "order_id": orderId,
//       //   "billing_data": billingData,
//       //   "integration_id": Constatns.integrationId,
//       // };
//       final data = {
//         "auth_token": authToken,
//         "amount_cents": amountCents,
//         "expiration": 3600,
//         "order_id": orderId,
//         "billing_data": billingData,
//         "currency": currency,
//         "integration_id": Constatns.integrationId, // Integration ID بتاعك
//       };

//       log("Requesting Payment Key with data: $data");

//       final response = await dio.post(
//         'https://accept.paymob.com/api/acceptance/payment_keys',
//         data: data,
//       );

//       log("Payment Key Response: ${response.data}");
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return response.data['token'];
//       }
//     } catch (e) {
//       log("getPaymentKey Error: $e");
//     }
//     return null;
//   }
// }
