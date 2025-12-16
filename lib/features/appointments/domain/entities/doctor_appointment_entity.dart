

import 'package:equatable/equatable.dart';
import 'package:medora/features/appointments/domain/entities/appointment_entity.dart' show AppointmentEntity;

class DoctorAppointmentEntity extends Equatable{


  final String appointmentId;

  final AppointmentEntity appointmentEntity;

  const DoctorAppointmentEntity({
    required this.appointmentId,
    required this.appointmentEntity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    appointmentId,
    appointmentEntity,
  ];
}