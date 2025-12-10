// domain/entities/doctor_entity.dart
import 'package:equatable/equatable.dart';

import 'doctor_availability_entity.dart';

class DoctorEntity extends Equatable {
  final String? doctorId;
  final String imageUrl;
  final String name;
  final List<String> specialties;
  final String bio;
  final String location;
  final DoctorAvailabilityEntity doctorAvailability; // استخدام Entity
  final int fees;

  const DoctorEntity({
    this.doctorId,
    required this.imageUrl,
    required this.name,
    required this.specialties,
    required this.bio,
    required this.location,
    required this.doctorAvailability, // Entity
    required this.fees,
  });

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
