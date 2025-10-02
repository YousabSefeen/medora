import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/book_appointment_model.dart';
import '../models/client_appointments_model.dart';
import '../models/doctor_appointment_model.dart';

abstract class AppointmentRepositoryBase {
  Future<Either<Failure, List<DoctorAppointmentModel>>> fetchDoctorAppointments({
    required String doctorId,
  });

  Future<Either<Failure, List<String>>> fetchReservedTimeSlotsForDoctorOnDate({
    required String doctorId,
    required String date,
  });

  Future<Either<Failure, void>> bookAppointment({
    required String doctorId,
   required BookAppointmentModel bookAppointmentModel,
  });

  Future<Either<Failure, void>> rescheduleAppointment({
    required String doctorId,
    required String appointmentId,
    required String appointmentDate,
    required String appointmentTime,
  });

  Future<Either<Failure, void>> cancelAppointment({
    required String doctorId,
    required String appointmentId,

  });


  Future<Either<Failure, List<ClientAppointmentsModel>?>>
      fetchClientAppointmentsWithDoctorDetails();
  Future<Either<Failure, void>>
  deleteAppointment({required String appointmentId,required String doctorId});

}
