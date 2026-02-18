import 'api_error.dart';

class ApiResult<T> {
  final T? data;
  final ErrorModel? error;
  final bool success;

  ApiResult({this.data, this.error, required this.success});
}
