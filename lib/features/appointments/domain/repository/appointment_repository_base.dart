import 'package:dartz/dartz.dart';
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

  Future<Either<Failure, void>> rescheduleAppointment({
    required Map<String, dynamic> queryParams,
  });

  Future<Either<Failure, void>> cancelAppointment({
    required Map<String, dynamic> queryParams,
  });



  Future<Either<Failure, List<ClientAppointmentsEntity>?>>
  fetchUpcomingAppointments();

  Future<Either<Failure, List<ClientAppointmentsEntity>?>>
  fetchCompletedAppointments();

  Future<Either<Failure, List<ClientAppointmentsEntity>?>>
  fetchCancelledAppointments();

  Future<Either<Failure, void>> deleteAppointment({
    required Map<String, dynamic> queryParams,
  });

  //New

  Future<Either<Failure, String>> bookAppointment({
    required Map<String, dynamic> queryParams,
  });

  Future<Either<Failure, void>> confirmAppointment({
    required Map<String, dynamic> queryParams,
  });
}
