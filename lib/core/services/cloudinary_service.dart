import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryService {

  static const String cloudName = 'dfls3gdea';
  static const String uploadPreset = "doctors_images";

  // تعريف كائن Dio - يفضل تقنياً تمريره عبر الـ Constructor أو استخدامه كـ Singleton
  static final Dio _dio = Dio();

  static Future<String> testUpload({
    required String doctorId,
  //  required File file,
    required String filePath,
  }) async {
    File file=File(filePath);
    final String url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    try {
      print("جاري رفع الصورة إلى Cloudinary باستخدام Dio...");

      // تجهيز البيانات باستخدام FormData
      FormData formData = FormData.fromMap({
        'upload_preset': uploadPreset,
        'folder': 'doctors',
        'public_id': doctorId,
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      // تنفيذ طلب الـ POST
      final response = await _dio.post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          // ميزة إضافية في Dio لمتابعة نسبة التحميل
          if (total != -1) {
            print("تقدم الرفع: ${(sent / total * 100).toStringAsFixed(0)}%");
          }
        },
      );
      String imageUrl='';

      if (response.statusCode == 200) {
        // Dio يقوم بعمل decode للـ JSON تلقائياً وتحويله إلى Map
        final data = response.data;
        print("✅ تم الرفع بنجاح!");
        print("رابط الصورة (URL): ${data['secure_url']}");

        print("معرف الصورة (Public ID): ${data['public_id']}");
        imageUrl=data['secure_url'];
      }
      return imageUrl;
    } on DioException catch (e) {
      // معالجة أخطاء Dio بشكل مفصل
      print("❌ فشل الرفع.");
      if (e.response != null) {
        print("كود الخطأ: ${e.response?.statusCode}");
        print("تفاصيل الخطأ: ${e.response?.data}");
      } else {
        print("رسالة الخطأ: ${e.message}");
      }

      return '';
    } catch (e) {

      print("❌ حدث خطأ غير متوقع: $e");
      rethrow;

      return '';
    }
  }
}

// By Http package

/*
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryTester {
  // استبدل هذه القيم ببياناتك من لوحة تحكم Cloudinary
  static const String cloudName =  'dfls3gdea';
  static const String uploadPreset = "doctors_images";

  static Future<void> testUpload({required String doctorId,required File file}) async {
    // final ImagePicker picker = ImagePicker();
    //
    // // 1. اختيار صورة من الهاتف
    // print("جاري اختيار الصورة...");
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //
    // if (image == null) {
    //   print("لم يتم اختيار أي صورة.");
    //   return;
    // }
    //
    // File file = File(image.path);

    // 2. تجهيز الرابط الخاص بالرفع
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    // 3. إنشاء طلب الرفع (Multipart Request)
   /* final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));*/
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = 'doctors' // 👈 هذا السطر سيقوم بإنشاء المجلد ووضع الصورة داخله تلقائياً
      ..fields['public_id'] = doctorId // اسم الصورة سيكون هو الـ UID الخاص بالطبيب
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    try {
      print("جاري رفع الصورة إلى Cloudinary...");
      final response = await request.send();

      if (response.statusCode == 200) {
        // الرفع نجح
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);

        print("✅ تم الرفع بنجاح!");
        print("رابط الصورة (URL): ${jsonMap['secure_url']}");
        print("معرف الصورة (Public ID): ${jsonMap['public_id']}");
      } else {
        print("❌ فشل الرفع. كود الخطأ: ${response.statusCode}");
        final errorData = await response.stream.bytesToString();
        print("تفاصيل الخطأ: $errorData");
      }
    } catch (e) {
      print("❌ حدث خطأ أثناء الاتصال: $e");
    }
  }
}
 */