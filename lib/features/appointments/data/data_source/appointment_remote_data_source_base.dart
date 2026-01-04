import 'package:medora/features/appointments/data/models/client_appointments_model.dart';
import 'package:medora/features/appointments/data/models/doctor_appointment_model.dart';

abstract class AppointmentRemoteDataSourceBase {
  Future<List<DoctorAppointmentModel>> fetchDoctorAppointments({
    required String doctorId,
  });

  Future<List<String>> fetchBookedTimeSlots({
    required Map<String, dynamic> queryParams,
  });

  Future<String> bookAppointment({required Map<String, dynamic> queryParams});

  Future<void> confirmAppointment({required Map<String, dynamic> queryParams});

  Future<void> rescheduleAppointment({
    required Map<String, dynamic> queryParams,
  });

  Future<void> cancelAppointment({
    required String doctorId,
    required String appointmentId,
  });

  Future<List<ClientAppointmentsModel>?> fetchClientAppointments();

  Future<void> deleteAppointment({
    required String appointmentId,
    required String doctorId,
  });
}
