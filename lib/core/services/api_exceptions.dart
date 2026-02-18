import 'package:dio/dio.dart';
import 'api_error.dart';

class ServerException implements Exception {
  final ErrorModel errmodel;

  ServerException({required this.errmodel});
  @override
  String toString() {
    // هنا بنحول الـ Exception لرسالة صريحة
    return errmodel.message ?? "Unknown error";
  }
}

// ServerException handleApiException(DioException e) {
//   // حالة السيرفر رجّع response لكن فيه error                                                // باقي الحالات → errors محلية (مفيش response من السيرفر)
//   String message;
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       message = "Connection timeout, please try again.";
//       break;
//     case DioExceptionType.sendTimeout:
//       message = "Send timeout, request took too long.";
//       break;
//     case DioExceptionType.receiveTimeout:
//       message = "Receive timeout, server is not responding.";
//       break;
//     case DioExceptionType.connectionError:
//       message = "No internet connection.....";
//       break;
//     case DioExceptionType.cancel:
//       message = "Request was cancelled.";
//       break;
//     case DioExceptionType.badCertificate:
//       message = "Bad certificate.";
//       break;
//     case DioExceptionType.unknown:
//       message = "Unexpected error occurred.";
//       break;
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400:
//           message = "Bad request.";
//           break;
//         case 401:
//           message = "Unauthorized.";
//           break;
//         case 403:
//           message = "Forbidden.";
//           break;
//         case 404:
//           message = "Not found.";
//           break;
//         case 500:
//           message = "Internal server error.";
//           break;
//         case 422:
//           message = "Already exists.";
//           break;
//         case 302:
//           message = "Already exists.";
//           break;
//         default:
//           message = "Unexpected error occurred.";
//       }
//   }

//   if (e.response?.data != null) {
//     return ServerException(errmodel: ErrorModel.fromJson(e.response!.data));
//   } else {
//     return ServerException(
//         errmodel: ErrorModel(
//       message: message,
//       statusCode: e.response?.statusCode,
//     ));
//   }
// }
//

ServerException handleApiException(DioException e) {
  String message;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      message = "Connection timeout, please try again.";
      break;
    case DioExceptionType.sendTimeout:
      message = "Send timeout, request took too long.";
      break;
    case DioExceptionType.receiveTimeout:
      message = "Receive timeout, server is not responding.";
      break;
    case DioExceptionType.connectionError:
      message = "No internet connection.";
      break;
    case DioExceptionType.cancel:
      message = "Request was cancelled.";
      break;
    case DioExceptionType.badCertificate:
      message = "Bad certificate.";
      break;
    case DioExceptionType.unknown:
      message = "Unexpected error occurred.";
      break;
    case DioExceptionType.badResponse:
      // 🚨 هنا نتأكد من الـ status
      switch (e.response?.statusCode) {
        case 400:
          message = "Bad request.";
          break;
        case 401:
          message = "Unauthorized.";
          break;
        case 403:
          message = "Forbidden.";
          break;
        case 404:
          message = "Not found.";
          break;
        case 422:
          message = "Already exists.";
          break;
        case 500:
          message = "Internal server error.";
          break;
        case 302:
          message = "Already exists";
          break;
        default:
          message = "Unexpected error occurred.";
      }
      break;
  }

  // ✅ تحقق من نوع response.data قبل fromJson
  final data = e.response?.data;
  if (data is Map<String, dynamic>) {
    return ServerException(errmodel: ErrorModel.fromJson(data));
  } else {
    return ServerException(
      errmodel: ErrorModel(
        message: message,
        statusCode: e.response?.statusCode,
      ),
    );
  }
}
