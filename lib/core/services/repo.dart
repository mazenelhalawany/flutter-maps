// import 'package:dio/dio.dart';
// import 'package:flutter_hungry_app/core/services/apiresult.dart';
// import '../models/user_model.dart';
// import '../services/api_service.dart';
// import '../services/api_exceptions.dart';
// import '../services/api_error.dart';

// class MyRepo {
//   final ApiService service;
//   final String? token;

//   MyRepo(this.service, {this.token});

//   // ------------------ USERS CRUD ------------------

//   Future<ApiResult<List<UserModel>>> getUserModels() async {
//     try {
//       final response = await service.getRequest('/users', token: token);

//       if (response is Map<String, dynamic> && response.containsKey('data')) {
//         final list = (response['data'] as List)
//             .map((json) => UserModel.fromJson(json))
//             .toList();
//         return ApiResult(data: list, success: true);
//       }
//       return ApiResult(
//           data: [],
//           success: false,
//           error: ErrorModel(message: 'No users found'));
//     } on DioException catch (e) {
//       return ApiResult(success: false, error: handleApiException(e).errmodel);
//     }
//   }

//   Future<ApiResult<UserModel>> createUser(UserModel user) async {
//     try {
//       final response = await service.postRequest('/users',
//           data: user.toJson(), token: token);

//       if (response is Map<String, dynamic> && response.containsKey('id')) {
//         return ApiResult(data: UserModel.fromJson(response), success: true);
//       }
//       return ApiResult(
//           success: false, error: ErrorModel(message: 'Failed to create user'));
//     } on DioException catch (e) {
//       return ApiResult(success: false, error: handleApiException(e).errmodel);
//     }
//   }

//   Future<ApiResult<void>> deleteUser(String id) async {
//     try {
//       await service.deleteRequest('/users/$id', token: token);
//       return ApiResult(success: true);
//     } on DioException catch (e) {
//       return ApiResult(success: false, error: handleApiException(e).errmodel);
//     }
//   }

//   // ------------------ AUTH ------------------

//   Future<ApiResult<UserModel>> login(String email, String password) async {
//     try {
//       final response = await service.postRequest('/login', data: {
//         'email': email,
//         'password': password,
//       });
//       if (response is Map<String, dynamic>) {
//         if (response.containsKey('id')) {
//           // response ناجح
//           return ApiResult(data: UserModel.fromJson(response), success: true);
//         } else if (response.containsKey('message')) {
//           // response فيه رسالة خطأ
//           return ApiResult(
//               success: false, error: ErrorModel(message: response['message']));
//         }
//       } else if (response is String) {
//         // response String فارغ أو رسالة نصية
//         return ApiResult(
//             success: false,
//             error: ErrorModel(
//                 message: response.isNotEmpty ? response : 'Login failed'));
//       }

//       // أي response غير متوقع
//       return ApiResult(
//           success: false, error: ErrorModel(message: 'Login failed'));
//     } on DioException catch (e) {
//       return ApiResult(success: false, error: handleApiException(e).errmodel);
//     }
//   }

//   Future<ApiResult<UserModel>> register(Map<String, dynamic> userData) async {
//     try {
//       final response = await service.postRequest('/register', data: userData);

//       if (response is Map<String, dynamic> && response.containsKey('id')) {
//         return ApiResult(data: UserModel.fromJson(response), success: true);
//       } else if (response is Map<String, dynamic> &&
//           response.containsKey('message')) {
//         return ApiResult(
//             success: false, error: ErrorModel(message: response['message']));
//       } else if (response is String) {
//         return ApiResult(
//             success: false,
//             error: ErrorModel(
//                 message: response.isNotEmpty ? response : 'Register failed'));
//       }
//       return ApiResult(
//           success: false, error: ErrorModel(message: 'Register failed'));
//     } on DioException catch (e) {
//       return ApiResult(success: false, error: handleApiException(e).errmodel);
//     }
//   }
// }
