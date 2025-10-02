import 'package:dio/dio.dart';

class DioFailure {
  final Object catchError;

  DioFailure({required this.catchError});

  String get errorMessage {
    if (catchError is DioException) {
      final dioError = catchError as DioException;

      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout with ApiServer.';
        case DioExceptionType.sendTimeout:
          return 'Connection send timeout with ApiServer.';
        case DioExceptionType.receiveTimeout:
          return 'Connection receive timeout with ApiServer.';
        case DioExceptionType.badCertificate:
          return 'Bad Certificate.';
        case DioExceptionType.badResponse:
          return fromResponse(
              dioError.response!.statusCode, dioError.response!.data);
        case DioExceptionType.cancel:
          return 'Request to ApiServer was canceled';
        case DioExceptionType.connectionError:
          return 'No internet connection';
        case DioExceptionType.unknown:
          return 'An error occurred,Please try again';
      }
    }

    // رسالة عامة في حال كان الخطأ من نوع غير متوقع.
    return "An unexpected error occurred: ${catchError.toString()}";
  }

  fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return response['error']['message'];
    } else if (statusCode == 404) {
      return 'Your request is not found,Please try later!.';
    } else if (statusCode == 500) {
      return 'Internal server error,Please try later!.';
    } else {
      return 'Opps there was an error,Please try again';
    }
  }

  @override
  String toString() {
    return errorMessage;
  }
}
