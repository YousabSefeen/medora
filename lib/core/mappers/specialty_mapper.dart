/*

abstract class SpecialtyMapper {
  // خريطة التخصصات: الاسم العلمي مقابل الـ ID
  static const Map<String, int> _specialtyMap = {
    'Otolaryngology': 1,     // الأنف والأذن والحنجرة
    'Dermatology': 2,        // الجلدية
    'Cardiology': 3,         // القلب والأوعية الدموية
    'Ophthalmology': 4,      // الرمد والعيون
    'Orthopedics': 5,        // العظام
    'Pediatrics': 6,         // الأطفال
    'Neurology': 7,          // المخ والأعصاب
    'Psychiatry': 8,         // الطب النفسي
    'Gastroenterology': 9,   // الجهاز الهضمي
    'Obstetrics and Gynecology': 10, // النساء والتوليد
    'Urology': 11,           // المسالك البولية
    'Endocrinology': 12,     // الغدد الصماء
    'Pulmonology': 13,       // الصدر والجهاز التنفسي
    'Rheumatology': 14,      // الروماتيزم
    'Dentistry': 15,         // الأسنان
    'Internal Medicine': 16, // الباطنة العامة
    'General Surgery': 17,   // الجراحة العامة
    'Oncology': 18,          // الأورام
    'Nephrology': 19,        // الكلى
    'Hematology': 20,
    'None': -1, // كود خاص للحالات غير الطبية// أمراض الدم
  };
// خريطة الترجمة المحلية (ID -> Arabic Name)
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
    -1:'لا شئ'
  };

  /// استخراج الـ ID من الاسم العلمي
  static int getSpecialtyId(String specialtyName) {
    return _specialtyMap[specialtyName.trim()] ?? 0;
  }

  /// استخراج الاسم العربي من الـ ID لعرضه في الواجهة
  static String getArabicName(int id) {
    return _arabicNames[id] ?? 'تخصص طبي عام';
  }
  // /// وظيفة للحصول على الـ ID بناءً على اسم التخصص القادم من Gemini
  // static int getSpecialtyId(String specialtyName) {
  //   // التنظيف: إزالة المسافات الزائدة وتحويلها لحالة الأحرف الصحيحة للمطابقة
  //   final cleanedName = specialtyName.trim();
  //
  //   // البحث في الخريطة، وإرجاع 0 (أو أي قيمة افتراضية) إذا لم يتم العثور على التخصص
  //   return _specialtyMap[cleanedName] ?? 0;
  // }
  //
  // /// وظيفة اختيارية للتحقق مما إذا كان التخصص موجوداً
  // static bool exists(String specialtyName) => _specialtyMap.containsKey(specialtyName.trim());
}*/
abstract class SpecialtyMapper {
  // 1. خريطة الكلمات المفتاحية (Keywords) لضمان أقصى درجات المرونة
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
    'none': -1,                                              // لا شيء
  };

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

  /// استخراج الـ ID بطريقة البحث المرن عن الكلمات المفتاحية
  static int getSpecialtyId(String specialtyName) {
    final String input = specialtyName.trim().toLowerCase();

    // نمر على خريطة الكلمات المفتاحية، إذا وجدنا أي جزء منها في النص المدخل
    for (var entry in _keywordsMap.entries) {
      if (input.contains(entry.key)) {
        return entry.value;
      }
    }

    return 0; // تخصص غير معروف (طبي عام)
  }

  static String getArabicName(int id) {
    return _arabicNames[id] ?? 'تخصص طبي عام';
  }
}