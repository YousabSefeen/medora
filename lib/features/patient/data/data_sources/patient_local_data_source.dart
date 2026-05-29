import 'dart:convert';

import 'package:medora/features/patient/data/models/patient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PatientLocalDataSource {
  Future<void> cachePatientData(PatientModel patient);

  PatientModel? getCachedPatientData();

  Future<void> clearCachedPatientData();
}

class PatientLocalDataSourceImpl implements PatientLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _patientFieldsKey = 'cached_patient_fields';

  PatientLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cachePatientData(PatientModel patientModel) async {
    final String jsonData = jsonEncode(patientModel.toJson());
    await sharedPreferences.setString(_patientFieldsKey, jsonData);
  }

  @override
  PatientModel? getCachedPatientData() {
    final String? jsonData = sharedPreferences.getString(_patientFieldsKey);
    if (jsonData != null) {
      final Map<String, dynamic> data = jsonDecode(jsonData);
      return PatientModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<void> clearCachedPatientData() async {
    await sharedPreferences.remove(_patientFieldsKey);
  }
}
