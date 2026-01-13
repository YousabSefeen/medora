import 'package:medora/features/appointments/data/models/doctor_appointment_model.dart';
import 'package:medora/features/appointments/data/models/paginated_appointments_response.dart'
    show PaginatedAppointmentsResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

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

  Future<void> cancelAppointment({required Map<String, dynamic> queryParams});

  /*  Future<List<ClientAppointmentsModel>?> fetchUpcomingAppointments();
  Future<List<ClientAppointmentsModel>?> fetchCompletedAppointments();
  Future<List<ClientAppointmentsModel>?> fetchCancelledAppointments();*/

  Future<PaginatedAppointmentsResponse> fetchUpcomingAppointments({
    PaginationParameters parameters,
  });

  Future<PaginatedAppointmentsResponse> fetchCompletedAppointments({
    PaginationParameters parameters,
  });

  Future<PaginatedAppointmentsResponse> fetchCancelledAppointments({
    PaginationParameters parameters,
  });

  Future<void> deleteAppointment({required Map<String, dynamic> queryParams});
}
