// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
  name: json['name'] as String,
  age: json['age'] as String,
  problem: json['problem'] as String,
  gender: $enumDecode(_$GenderTypeEnumMap, json['gender']),
);

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'problem': instance.problem,
      'gender': _$GenderTypeEnumMap[instance.gender]!,
    };

const _$GenderTypeEnumMap = {
  GenderType.init: 'init',
  GenderType.male: 'male',
  GenderType.female: 'female',
};
