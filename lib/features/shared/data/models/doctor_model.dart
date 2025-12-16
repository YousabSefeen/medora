import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

import 'doctor_availability_model.dart';

part 'doctor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorModel extends Equatable {
  final String? doctorId;
  final String imageUrl;
  final String name;
  final List<String> specialties;
  final String bio;

  final String location;


  final DoctorAvailabilityModel doctorAvailability;

  final int fees;

  const DoctorModel({
    this.doctorId,
    required this.imageUrl,
    required this.name,
    required this.specialties,
    required this.bio,
    required this.location,
    required this.doctorAvailability,
    required this.fees,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);


  DoctorEntity toEntity() {
    return DoctorEntity(
      doctorId: doctorId,
      imageUrl: imageUrl,
      name: name,
      specialties: specialties,
      bio: bio,
      location: location,

      doctorAvailability: doctorAvailability.toEntity(),
      fees: fees,
    );
  }
  factory DoctorModel.fromEntity(DoctorEntity entity) {
    return DoctorModel(
      doctorId: entity.doctorId,
      imageUrl: entity.imageUrl,
      name: entity.name,
      specialties: entity.specialties,
      bio: entity.bio,
      location: entity.location,
      doctorAvailability: DoctorAvailabilityModel.fromEntity(entity.doctorAvailability),
      fees: entity.fees,
    );
  }
  @override
  List<Object?> get props => [
    doctorId,
    imageUrl,
    name,
    specialties,
    bio,
    location,
    doctorAvailability,
    fees,
  ];
}
