import 'package:medora/features/appointments/data/models/doctor_appointment_model.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;

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



  Future<PaginatedDataResponse<ClientAppointmentsEntity>> fetchUpcomingAppointments({
    required   PaginationParameters parameters,
  });

  Future<PaginatedDataResponse<ClientAppointmentsEntity>> fetchCompletedAppointments({
    required PaginationParameters parameters,
  });

  Future<PaginatedDataResponse<ClientAppointmentsEntity>> fetchCancelledAppointments({
    required   PaginationParameters parameters,
  });

  Future<void> deleteAppointment({required Map<String, dynamic> queryParams});
}
