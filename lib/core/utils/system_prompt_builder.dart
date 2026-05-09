


import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/utils/language_detector.dart' show LanguageDetector;
import 'package:medora/core/utils/specialty_translator.dart' show SpecialtyTranslator;

class SystemPromptBuilder {
  final List<String> supportedSpecialties;

  const SystemPromptBuilder({required this.supportedSpecialties});

  String build(String userMessage) {
    final language = LanguageDetector.detectLanguage(userMessage);
    return language == 'arabic'
        ? _buildArabicPrompt()
        : _buildEnglishPrompt();
  }

  String _buildArabicPrompt() {
    final specialties = supportedSpecialties.join('، ');
    return AppStrings.systemInstructionArabic.replaceFirst('%s', specialties);
  }

  String _buildEnglishPrompt() {
    final englishSpecialties = SpecialtyTranslator.translateSpecialties(supportedSpecialties);
    return AppStrings.systemInstructionEnglish.replaceFirst('%s', englishSpecialties.join(', '));
  }
}