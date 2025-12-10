// domain/entities/doctor_availability_entity.dart
import 'package:equatable/equatable.dart';

class DoctorAvailabilityEntity extends Equatable {
  final List<String> workingDays;
  final String? availableFrom;
  final String? availableTo;

  const DoctorAvailabilityEntity({
    required this.workingDays,
    required this.availableFrom,
    required this.availableTo,
  });

  @override
  List<Object?> get props => [workingDays, availableFrom, availableTo];
}
