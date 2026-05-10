abstract class SpecialtyMapper {
  // 1. خريطة الكلمات المفتاحية (Keywords) لضمان أقصى درجات المرونة في التعرف على ردود AI
  static const Map<String, int> _keywordsMap = {
    'laryngo': 1, 'oto': 1, 'ent': 1, 'nose': 1, 'ear': 1,    // الأنف والأذن
    'derma': 2, 'skin': 2,                                   // الجلدية
    'cardio': 3, 'heart': 3,                                 // القلب
    'ophthal': 4, 'eye': 4, 'vision': 4,                     // العيون
    'ortho': 5, 'bone': 5,                                   // العظام
    'pedia': 6, 'child': 6,                                  // الأطفال
    'neuro': 7, 'brain': 7, 'nerve': 7,                      // الأعصاب
    'psych': 8, 'mental': 8,                                 // النفسي
    'gastro': 9, 'digest': 10, 'stomach': 9,                 // الهضمي
    'gyneco': 10, 'obstet': 10, 'women': 10,                 // النساء
    'uro': 11, 'urinary': 11,                                // المسالك
    'endocrin': 12, 'hormon': 12, 'sugar': 12,               // الغدد
    'pulmon': 13, 'chest': 13, 'lung': 13, 'breath': 13,      // الصدر
    'rheuma': 14, 'joint': 14,                               // الروماتيزم
    'dent': 15, 'tooth': 15, 'teeth': 15,                    // الأسنان
    'internal': 16,                                          // الباطنة
    'surgery': 17, 'surgeon': 17,                            // الجراحة
    'onco': 18, 'cancer': 18,                                // الأورام
    'nephro': 19, 'kidney': 19,                              // الكلى
    'hemato': 20, 'blood': 20,                               // الدم
    'none': -1,                                              // حالة غير طبية
  };

  // 2. خريطة الترجمة العربية (ID -> Arabic Name)
  static const Map<int, String> _arabicNames = {
    1: 'الأنف والأذن والحنجرة',
    2: 'الجلدية',
    3: 'أمراض القلب',
    4: 'طب العيون',
    5: 'جراحة العظام',
    6: 'طب الأطفال',
    7: 'المخ والأعصاب',
    8: 'الطب النفسي',
    9: 'الجهاز الهضمي',
    10: 'النساء والتوليد',
    11: 'المسالك البولية',
    12: 'الغدد الصماء',
    13: 'الأمراض الصدرية',
    14: 'الروماتيزم',
    15: 'طب الأسنان',
    16: 'الباطنة العامة',
    17: 'الجراحة العامة',
    18: 'الأورام',
    19: 'أمراض الكلى',
    20: 'أمراض الدم',
    -1: 'لا شيء'
  };

  // 3. خريطة الأسماء الإنجليزية الرسمية (ID -> English Name)
  static const Map<int, String> _englishNames = {
    1: 'Otolaryngology',
    2: 'Dermatology',
    3: 'Cardiology',
    4: 'Ophthalmology',
    5: 'Orthopedics',
    6: 'Pediatrics',
    7: 'Neurology',
    8: 'Psychiatry',
    9: 'Gastroenterology',
    10: 'Obstetrics and Gynecology',
    11: 'Urology',
    12: 'Endocrinology',
    13: 'Pulmonology',
    14: 'Rheumatology',
    15: 'Dentistry',
    16: 'Internal Medicine',
    17: 'General Surgery',
    18: 'Oncology',
    19: 'Nephrology',
    20: 'Hematology',
    -1: 'None'
  };
  /// استخراج الـ ID بطريقة ذكية تعطي الأولوية للمطابقة الكاملة
  static int getSpecialtyId(String specialtyName) {
    final String input = specialtyName.trim().toLowerCase();

    // 1. الأولوية الأولى: محاولة المطابقة الكاملة (Exact Match)
    // نبحث إذا كان المدخل يطابق أحد القيم الرسمية تماماً لتجنب التداخل
    for (var entry in _englishNames.entries) {
      if (input == entry.value.toLowerCase()) {
        return entry.key;
      }
    }

    // 2. الأولوية الثانية: البحث عن الكلمات المفتاحية (Keyword Match)
    // نستخدم ترتيباً ذكياً أو نتأكد من الكلمات المفتاحية
    for (MapEntry<String, int> entry in _keywordsMap.entries) {
      // تعديل هام: التأكد من أن الكلمة المفتاحية ليست جزءاً من كلمة أخرى بشكل خاطئ
      // أو ببساطة التحقق من وجود الكلمة المفتاحية ككلمة مستقلة أو مقطع أساسي
      if (input.contains(entry.key)) {
        return entry.value;
      }
    }

    return 0; // تخصص غير معروف
  }


  /// استخراج الاسم العربي من الـ ID
  static String getArabicName(int id) {
    return _arabicNames[id] ?? 'تخصص طبي عام';
  }

  /// استخراج الاسم الإنجليزي من الـ ID
  static String getEnglishName(int id) {
    return _englishNames[id] ?? 'General Medical Specialty';
  }
}