



class SpecialtyTranslator {
  static const Map<String, String> _specialtyMap = {
    'الجلدية': 'Dermatology',
    'القلب والأوعية الدموية': 'Cardiology',
    'العظام': 'Orthopedics',
    'الأطفال': 'Pediatrics',
    'العيون': 'Ophthalmology',
  };

  static String toEnglish(String arabicSpecialty) {
    return _specialtyMap[arabicSpecialty] ?? arabicSpecialty;
  }

  static List<String> translateSpecialties(List<String> arabicSpecialties) {
    return arabicSpecialties.map(toEnglish).toList();
  }
}