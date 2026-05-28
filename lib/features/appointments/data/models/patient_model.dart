

import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/appointments/domain/entities/patient_entity.dart';
import 'package:medora/core/enum/gender_type.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel extends PatientEntity {
  const PatientModel({
    required String name,
    required String age,
    required String problem,
    required GenderType gender,
  }) : super(
    name: name,
    age: age,
    problem: problem,
    gender: gender,
  );

  // تحويل من JSON
  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);

  // تحويل إلى JSON
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);

  // التحويل من وإلى الـ Entity (الجسر بين الطبقات)
  factory PatientModel.fromEntity(PatientEntity entity) {
    return PatientModel(
      name: entity.name,
      age: entity.age,
      problem: entity.problem,
      gender: entity.gender,
    );
  }

  PatientEntity toEntity() {
    return PatientEntity(
      name: name,
      age: age,
      problem: problem,
      gender: gender,
    );
  }
}


