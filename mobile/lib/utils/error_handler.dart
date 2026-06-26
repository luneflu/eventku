import 'package:dio/dio.dart';

String extractErrorMessage(dynamic error) {
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map) {
      if (data['errors'] != null && data['errors'] is Map) {
        final Map<String, dynamic> errors = data['errors'];
        if (errors.isNotEmpty) {
          final firstErrorList = errors.values.first;
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            return firstErrorList.first.toString();
          }
        }
      }
      if (data['message'] != null) {
        return data['message'].toString();
      }
    }
    return error.message ?? 'Unknown API error';
  }
  return error?.toString().replaceFirst('Exception: ', '') ?? 'Unknown error';
}
