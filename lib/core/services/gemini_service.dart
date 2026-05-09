//
//
//
//
// // features/chat/gemini_service.dart
// import 'dart:typed_data';
// import 'package:flutter_gemini/flutter_gemini.dart';
//
// // features/chat/gemini_service.dart
// import 'dart:async';
//
//
//
//
// class GeminiService {
//   final Gemini _gemini;
//   final int _maxRetries = 5;
//   final List<String> _availableModels = [
//     'gemini-2.0-flash',     // الأكثر استقرارًا
//     'gemini-1.5-flash',     // مستقر جدًا
//     'gemini-2.5-flash',     // قد يكون مزدحمًا أحيانًا
//     'gemini-1.5-pro',       // للطلبات المعقدة
//   ];
//
//   GeminiService() : _gemini = Gemini.instance;
//
//   // إرسال رسالة مع إعادة المحاولة ونماذج بديلة
//   Stream<String> sendMessageWithRetry(String prompt) {
//     final controller = StreamController<String>();
//
//     _sendMessageWithFallback(prompt).then((_) {
//       controller.close();
//     }).catchError((error) {
//       controller.addError(error);
//       controller.close();
//     });
//
//     return controller.stream.asBroadcastStream();
//   }
//
//   Future<void> _sendMessageWithFallback(String prompt) async {
//     Exception lastError = Exception('Unknown error');
//
//     for (int modelIndex = 0; modelIndex < _availableModels.length; modelIndex++) {
//       final model = _availableModels[modelIndex];
//
//       for (int attempt = 1; attempt <= _maxRetries; attempt++) {
//         try {
//           await _processStreamWithModel(prompt, model, attempt);
//           return; // نجاح - نخرج من الدالة
//         } catch (e) {
//           lastError = e as Exception;
//
//           if (e.toString().contains('503') || e.toString().contains('service unavailable')) {
//             print('⚠️ النموذج $model مشغول (محاولة $attempt/$_maxRetries)');
//
//             if (attempt < _maxRetries) {
//               // زيادة وقت الانتظار مع كل محاولة (Exponential Backoff)
//               final waitTime = Duration(seconds: _calculateBackoffTime(attempt));
//               print('⏳ انتظر ${waitTime.inSeconds} ثواني قبل المحاولة التالية...');
//               await Future.delayed(waitTime);
//               continue;
//             } else {
//               // نفذت محاولات هذا النموذج، جرب النموذج التالي
//               print('🔄 النموذج $model فشل، أجرب النموذج التالي...');
//               break;
//             }
//           } else {
//             // خطأ آخر ليس 503 - نعيد طرحه فورًا
//             rethrow;
//           }
//         }
//       }
//     }
//
//     throw Exception('فشل كل النماذج بعد $_maxRetries محاولات لكل نموذج. آخر خطأ: $lastError');
//   }
//
//   int _calculateBackoffTime(int attempt) {
//     // 2^attempt ثواني: 2, 4, 8, 16, 32
//     final seconds = 1 << attempt; // نفس معنى 2^attempt
//     return seconds > 30 ? 30 : seconds; // الحد الأقصى 30 ثانية
//   }
//
//   Future<void> _processStreamWithModel(String prompt, String model, int attempt) async {
//     final completer = Completer<void>();
//     bool hasData = false;
//
//     // إعداد Gemini مع النموذج المحدد
//     final request = _gemini.streamGenerateContent(
//       prompt,
//       modelName: model, // تحديد النموذج
//     );
//
//     await for (final value in request) {
//       hasData = true;
//       // البيانات سترسل من خلال StreamController الخارجي
//       // نضيفها إلى StreamController الرئيسي من خلال callback
//     }
//
//     if (!hasData) {
//       throw Exception('$model: لا توجد بيانات في الرد');
//     }
//
//     completer.complete();
//     return completer.future;
//   }
//
//   // إرسال صورة مع إعادة المحاولة ونماذج بديلة
//   Future<String> sendImageWithRetry(Uint8List imageBytes, String prompt) async {
//     Exception lastError = Exception('Unknown error');
//
//     for (int modelIndex = 0; modelIndex < _availableModels.length; modelIndex++) {
//       final model = _availableModels[modelIndex];
//
//       for (int attempt = 1; attempt <= _maxRetries; attempt++) {
//         try {
//           return await _sendImageWithModel(imageBytes, prompt, model);
//         } catch (e) {
//           lastError = e as Exception;
//
//           if (e.toString().contains('503') || e.toString().contains('service unavailable')) {
//             print('⚠️ النموذج $model مشغول (محاولة $attempt/$_maxRetries)');
//
//             if (attempt < _maxRetries) {
//               final waitTime = Duration(seconds: _calculateBackoffTime(attempt));
//               print('⏳ انتظر ${waitTime.inSeconds} ثواني...');
//               await Future.delayed(waitTime);
//               continue;
//             } else {
//               print('🔄 النموذج $model فشل، أجرب النموذج التالي...');
//               break;
//             }
//           } else {
//             rethrow;
//           }
//         }
//       }
//     }
//
//     throw Exception('فشل كل النماذج. آخر خطأ: $lastError');
//   }
//
//   Future<String> _sendImageWithModel(Uint8List imageBytes, String prompt, String model) async {
//     final response = await _gemini.textAndImage(
//       text: prompt,
//       images: [imageBytes],
//       modelName: model, // تحديد النموذج
//     );
//
//     if (response != null && response.content != null) {
//       final part = response.content!.parts!.last;
//       if (part is TextPart) {
//         return part.text;
//       } else if (response.output != null) {
//         return response.output!;
//       }
//     }
//
//     throw Exception('$model: رد غير صالح من الخادم');
//   }
//
//   // دالة مساعدة لاختبار الاتصال
//   Future<bool> testConnection() async {
//     try {
//       final result = await _gemini.textAndImage(
//         text: 'Test connection',
//         images: [],
//         modelName: 'gemini-2.0-flash',
//       ).timeout(const Duration(seconds: 10));
//
//       return result != null;
//     } catch (e) {
//       print('Connection test failed: $e');
//       return false;
//     }
//   }
// }