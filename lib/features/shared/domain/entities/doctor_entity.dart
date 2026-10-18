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
  final int patientsCount;
  final double rating;
  final int ratingCount;

  const DoctorEntity({
    this.doctorId,
    required this.imageUrl,
    required this.name,
    required this.specialties,
    required this.bio,
    required this.location,
    required this.doctorAvailability, // Entity
    required this.fees,
    required this.patientsCount,
    required this.rating,
    required this.ratingCount,
  });
  DoctorEntity copyWith({
    String? doctorId,
    String? imageUrl,
    String? name,
    List<String>? specialties,
    String? bio,
    String? location,
    DoctorAvailabilityEntity? doctorAvailability,
    int? fees,
    int? patientsCount,
    double? rating,
    int? ratingCount,
  }) {
    return DoctorEntity(
      doctorId: doctorId ?? this.doctorId,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      specialties: specialties ?? this.specialties,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      doctorAvailability: doctorAvailability ?? this.doctorAvailability,
      fees: fees ?? this.fees,
      patientsCount: patientsCount ?? this.patientsCount,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
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
    patientsCount,
    rating,
    ratingCount,
  ];
}
