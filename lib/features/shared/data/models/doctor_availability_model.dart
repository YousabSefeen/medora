import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/shared/domain/entities/doctor_availability_entity.dart'
    show DoctorAvailabilityEntity;

part 'doctor_availability_model.g.dart';

@JsonSerializable()
class DoctorAvailabilityModel {
  final List<String> workingDays;
  final String? availableFrom;
  final String? availableTo;

  DoctorAvailabilityModel({
    required this.workingDays,
    required this.availableFrom,
    required this.availableTo,
  });

  factory DoctorAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorAvailabilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorAvailabilityModelToJson(this);

  DoctorAvailabilityEntity toEntity() {
    return DoctorAvailabilityEntity(
      workingDays: workingDays,
      availableFrom: availableFrom,
      availableTo: availableTo,
    );
  }
  factory DoctorAvailabilityModel.fromEntity(DoctorAvailabilityEntity entity) {
    return DoctorAvailabilityModel(
      workingDays: entity.workingDays,
      availableFrom: entity.availableFrom,
      availableTo: entity.availableTo,
    );
  }
}
