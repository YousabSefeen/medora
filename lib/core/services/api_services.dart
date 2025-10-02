import 'package:dio/dio.dart';

class ApiServices {
  final Dio dio = Dio();

  Future<Response> post({
    required String url,
      Map<String, dynamic>? data,
    String? token,
    required Options options,
  }) async {
    final response = await dio.post(url, data: data, options: options);
    return response;
  }
}
