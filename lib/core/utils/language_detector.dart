



// core/utils/language_detector.dart
import 'package:medora/core/enum/languages.dart' show Languages;

class LanguageDetector {
//  static final RegExp _arabicRegex = RegExp(r'[\u0600-\u06FF]');

  // static Languages detect(String text) {
  //   int arabicCount = 0;
  //
  //   for (int i = 0; i < text.length; i++) {
  //     if (_arabicRegex.hasMatch(text[i])) {
  //       arabicCount++;
  //     }
  //   }
  //
  //   final arabicRatio = text.isNotEmpty ? arabicCount / text.length : 0;
  //   return arabicRatio > 0.3 ? Languages.arabic: Languages.english;
  // }

 // static bool isArabic(String text) => detect(text) == 'arabic';

  // unction
 static Languages detectLanguage(String text) {
    // قائمة الحروف العربية
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');

    // حساب نسبة الأحرف العربية في النص
    int arabicCount = 0;
    int totalCount = 0;

    for (int i = 0; i < text.length; i++) {
      if (arabicRegex.hasMatch(text[i])) {
        arabicCount++;
      }
      totalCount++;
    }

    double arabicRatio = totalCount > 0 ? arabicCount / totalCount : 0;

    // إذا كان أكثر من 30% من النص عربي، اعتبره عربي
    if (arabicRatio > 0.3) {
      return Languages.arabic;
    } else {
      return Languages.english;
    }
  }
}