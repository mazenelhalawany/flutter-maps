import 'package:dio/dio.dart';
import 'api_error.dart';
import 'api_exceptions.dart';

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  Future<dynamic> get(String endpoint, {dynamic queryParams}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      throw handleApiException(e);
    } catch (e) {
      throw ServerException(errmodel: ErrorModel(message: e.toString()));
    }
  }
}
//   Future<UserModel> put(String endpoint, dynamic body) async {
//     try {
//       final formData = FormData.fromMap(body);

//       final response = await dio.post(endpoint, data: formData);
//       return response.data;
//     } on DioException catch (e) {
//       throw handleApiException(e);
//     } catch (e) {
//       throw ServerException(
//         errmodel: ErrorModel(message: e.toString()),
//       );
//     }
//   }

//   Future<dynamic> delete(String endpoint, {Map<String, dynamic>? body}) async {
//     try {
//       final response = await dio.delete(endpoint, data: body);
//       return response.data;
//     } on DioException catch (e) {
//       throw handleApiException(e);
//     } catch (e) {
//       throw ServerException(
//         errmodel: ErrorModel(message: e.toString()),
//       );
//     }
//   }
// }
