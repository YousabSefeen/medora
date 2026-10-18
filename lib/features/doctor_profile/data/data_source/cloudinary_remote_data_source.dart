import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medora/core/constants/keys/app_keys.dart';
import 'package:medora/core/services/logger_service.dart';

class CloudinaryRemoteDataSource {
  final Dio _dio;

  final String _cloudName = AppKeys.cloudinaryName;
  final String _uploadPreset = 'doctors_images';

  CloudinaryRemoteDataSource(this._dio);

  Future<String> uploadImage({
    required String doctorId,
    required String filePath,
  }) async {
    final file = File(filePath);
    final url = 'https://api.cloudinary.com/v1_1/$_cloudName/image/upload';

    try {
      final formData = FormData.fromMap({
        'upload_preset': _uploadPreset,
        'folder': 'doctors',
        'public_id': doctorId,
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200 && response.data != null) {
        AppLogger.warning('Success');

        // secure_url will directly contain the image link after automatic cropping and background removal.
        return response.data['secure_url'] as String;
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Failed to upload image to Cloudinary',
      );
    } catch (e) {
      AppLogger.error('CloudinaryRemoteDataSource/uploadImage  $e');
      rethrow;
    }
  }
}
