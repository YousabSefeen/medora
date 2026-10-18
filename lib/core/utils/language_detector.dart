import 'package:medora/core/enum/languages.dart' show Languages;

class LanguageDetector {
  static Languages detectLanguage(String text) {
    // List of Arabic letters
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');

    // Calculating the percentage of Arabic characters in the text
    int arabicCount = 0;
    int totalCount = 0;

    for (int i = 0; i < text.length; i++) {
      if (arabicRegex.hasMatch(text[i])) {
        arabicCount++;
      }
      totalCount++;
    }

    double arabicRatio = totalCount > 0 ? arabicCount / totalCount : 0;

    // If more than 30% of the text is Arabic, consider it Arabic.
    if (arabicRatio > 0.3) {
      return Languages.arabic;
    } else {
      return Languages.english;
    }
  }
}
