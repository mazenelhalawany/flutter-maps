// import 'package:dio/dio.dart';

// class DioClient {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: "https://nominatim.openstreetmap.org/",
//       headers: {'User-Agent': 'com.example.flutter_application_testmaps'},
//       connectTimeout: const Duration(milliseconds: 30000),
//       receiveTimeout: const Duration(milliseconds: 30000),
//     ),
//   );

//   DioClient() {
//     _dio.interceptors.add(
//       LogInterceptor(
//         requestBody: true,
//         responseBody: true,
//         requestHeader: true,
//         error: true,
//         request: true,
//       ),
//     );
//   }

//   Dio get dio => _dio;
// }
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'User-Agent': 'com.example.flutter_application_testmaps'},
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        error: true,
        request: true,
      ),
    );
  }

  Dio get dio => _dio;
}
