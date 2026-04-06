import 'dart:convert';

import 'package:animated_drop_down_form_field/animated_drop_down_form_field.dart';
import 'package:flutter/material.dart';
import 'package:medora/core/enum/gender_type.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

import '../../../../../core/base/disposable.dart';

// class PatientFieldsControllers implements Disposable {
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final genderController = AnimatedDropDownFormFieldController();
//   final ageController = TextEditingController();
//   final problemController = TextEditingController();
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     genderController.dispose();
//     ageController.dispose();
//     problemController.dispose();
//   }
// }

class PatientFieldsControllers implements Disposable {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();


  final ageController = TextEditingController();
  final problemController = TextEditingController();
  late final GenderType? genderType;
  Map<String, dynamic> toMap(GenderType genderType) {
    return {
      'name': nameController.text,
      'age': ageController.text,
      'problem': problemController.text,
      'gender': genderType.name,

    };
  }

  /// تعبئة الـ Controllers بالبيانات المسترجعة من التخزين المحلي
  void fromMap(Map<String, dynamic> data) {
    nameController.text = data['name'] ?? '';
    ageController.text = data['age'] ?? '';
    problemController.text = data['problem'] ?? '';
    if (data['gender'] != null) {
      genderType = GenderType.values.firstWhere(
            (e) => e.name == data['gender'],
        orElse: () => GenderType.init,
      );
  }
  }


  @override
  void dispose() {
    nameController.dispose();

    ageController.dispose();
    problemController.dispose();
  }
}

abstract class PatientLocalDataSource {
  Future<void> savePatientFields(Map<String, dynamic> data);

  Map<String, dynamic>? getPatientFields();

  Future<void> clearPatientFields();
}

class PatientLocalDataSourceImpl implements PatientLocalDataSource {
  final SharedPreferences sharedPreferences;

  // مفتاح ثابت لتخزين البيانات ومنع أخطاء الكتابة (Typo)
  static const String _patientFieldsKey = 'cached_patient_fields';

  PatientLocalDataSourceImpl(this.sharedPreferences);

  /// حفظ البيانات: نحول الـ Map إلى JSON String ثم نخزنه
  @override
  Future<void> savePatientFields(Map<String, dynamic> data) async {
    try {
      final String jsonData = jsonEncode(data);
      await sharedPreferences.setString(_patientFieldsKey, jsonData);
    } catch (e) {
      // يمكنك إضافة Logger هنا لتتبع الأخطاء
      rethrow;
    }
  }

  /// استرجاع البيانات: نأخذ الـ String ونحوله مرة أخرى إلى Map
  @override
  Map<String, dynamic>? getPatientFields() {
    final String? jsonData = sharedPreferences.getString(_patientFieldsKey);
    if (jsonData != null) {
      try {
        return jsonDecode(jsonData) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// مسح البيانات: يُفضل استدعاؤها بعد إتمام الحجز بنجاح
  @override
  Future<void> clearPatientFields() async {
    await sharedPreferences.remove(_patientFieldsKey);
  }
}
