import 'package:dartz/dartz.dart';

import 'package:medora/features/appointments/domain/entities/doctor_appointment_entity.dart'
    show DoctorAppointmentEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart' show PaginationParameters;

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



  Future<Either<Failure, PaginatedDataResponse>>
  fetchUpcomingAppointments({
   required PaginationParameters parameters,
  });

  Future<Either<Failure, PaginatedDataResponse>>
  fetchCompletedAppointments({
    required PaginationParameters parameters,
  });

  Future<Either<Failure, PaginatedDataResponse>>
  fetchCancelledAppointments({
    required  PaginationParameters parameters,
  });

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
