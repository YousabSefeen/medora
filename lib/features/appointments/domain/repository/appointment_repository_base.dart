import 'package:dartz/dartz.dart';
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart'
    show BookAppointmentEntity;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/entities/doctor_appointment_entity.dart'
    show DoctorAppointmentEntity;

import '../../../../core/error/failure.dart';

abstract class AppointmentRepositoryBase {
  Future<Either<Failure, List<DoctorAppointmentEntity>>>
  fetchDoctorAppointments({required String doctorId});

  Future<Either<Failure, List<String>>> fetchBookedTimeSlots({
    required Map<String, dynamic> queryParams,
  });

  Future<Either<Failure, void>> bookAppointment({
    required String doctorId,
    required BookAppointmentEntity bookAppointmentEntity,
  });

  Future<Either<Failure, void>> rescheduleAppointment({
    required Map<String, dynamic> queryParams,
  });

  Future<Either<Failure, void>> cancelAppointment({
    required String doctorId,
    required String appointmentId,
  });

  Future<Either<Failure, List<ClientAppointmentsEntity>?>>
  fetchClientAppointments();

  Future<Either<Failure, void>> deleteAppointment({
    required String appointmentId,
    required String doctorId,
  });
}
