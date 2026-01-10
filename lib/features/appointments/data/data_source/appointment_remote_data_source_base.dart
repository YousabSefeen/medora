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
    required Map<String, dynamic> queryParams,
  });


  Future<List<ClientAppointmentsModel>?> fetchUpcomingAppointments();
  Future<List<ClientAppointmentsModel>?> fetchCompletedAppointments();
  Future<List<ClientAppointmentsModel>?> fetchCancelledAppointments();

  Future<void> deleteAppointment({
    required Map<String, dynamic> queryParams,
  });
}
