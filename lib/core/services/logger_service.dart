

import 'package:logger/logger.dart';

class AppLogger {
  // إنشاء نسخة ثابتة (Singleton)
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,         // عدد أسطر الكود التي تظهر في الـ stack trace
      errorMethodCount: 5,    // عدد الأسطر في حالة وجود خطأ
      lineLength: 80,         // طول السطر
      colors: true,           // تلوين المخرجات في الـ Console
      printEmojis: true,      // إضافة رموز تعبيرية للتنظيم
    ),
  );

  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, {dynamic error, StackTrace? stackTrace})
  => _logger.e(message, error: error, stackTrace: stackTrace);
  static void debug(String message) => _logger.d(message);
}