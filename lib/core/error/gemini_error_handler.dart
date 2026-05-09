import 'package:medora/core/constants/app_strings/app_error_arabic_strings.dart'
    show AppErrorArabicStrings;
import 'package:medora/core/constants/app_strings/app_error_english_strings.dart'
    show AppErrorEnglishStrings;
import 'package:medora/core/enum/languages.dart' show Languages;

class GeminiErrorHandler {
  static String getErrorMessage({required Object error, required Languages language}) {
    final String rawError = error.toString();
final  bool isArabic=language==Languages.arabic;
    // 1. أخطاء الازدحام والضغط (503 / Overloaded)
    if (rawError.contains('503') ||
        rawError.contains('overloaded') ||
        rawError.contains('RESOURCE_EXHAUSTED')) {
      return isArabic
          ? AppErrorArabicStrings.geminiServiceUnavailable
          : AppErrorEnglishStrings.geminiServiceUnavailable;
    }

    // 2. أخطاء كثرة الطلبات (429 / Rate Limit)
    if (rawError.contains('429') || rawError.toLowerCase().contains('rate')) {
      return isArabic
          ? AppErrorArabicStrings.rateLimitExceeded
          : AppErrorEnglishStrings.rateLimitExceeded;
    }

    // 3. أخطاء الصلاحيات والمنطقة الجغرافية (401 / 403)
    if (rawError.contains('401') ||
        rawError.contains('403') ||
        rawError.contains('PERMISSION_DENIED')) {
      return isArabic
          ? AppErrorArabicStrings.serviceRestricted
          : AppErrorEnglishStrings.serviceRestricted;
    }

    // 4. أخطاء البيانات المدخلة (400 / Invalid Argument)
    if (rawError.contains('400') || rawError.contains('INVALID_ARGUMENT')) {
      return isArabic
          ? AppErrorArabicStrings.invalidRequest
          : AppErrorEnglishStrings.invalidRequest;
    }

    // 5. أخطاء الشبكة (Socket / Timeout)
    if (rawError.contains('SocketException') || rawError.contains('network_error')) {
      return isArabic
          ? AppErrorArabicStrings.networkError
          : AppErrorEnglishStrings.networkError;
    }

    // 6. الحالة الافتراضية لأي خطأ غير مبرمج
    return isArabic
        ? AppErrorArabicStrings.unknownError
        : AppErrorEnglishStrings.unknownError;
  }
}
