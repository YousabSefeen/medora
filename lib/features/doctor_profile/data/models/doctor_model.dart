import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../shared/models/availability_model.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
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
