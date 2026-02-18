class ErrorModel {
  final String? message;
  final int? statusCode;
  ErrorModel({required this.message, this.statusCode});

   factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json['code'] as int?,
      message: json['message'] as String?,
    );
  }
}
