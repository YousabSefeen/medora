import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart' show Failure, ServerFailure;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;

import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

import '../../domain/entities/doctor_appointment_entity.dart';
import '../../domain/repository/appointment_repository_base.dart';
import '../data_source/appointment_remote_data_source_base.dart';

class AppointmentRepositoryImpl extends AppointmentRepositoryBase {
  final AppointmentRemoteDataSourceBase remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorAppointmentEntity>>>
  fetchDoctorAppointments({required String doctorId}) async {
    try {
      final models = await remoteDataSource.fetchDoctorAppointments(
        doctorId: doctorId,
      );

      final entities = models.map((model) => model.toEntity()).toList();
      return right(entities);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchBookedTimeSlots({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      final timeSlots = await remoteDataSource.fetchBookedTimeSlots(
        queryParams: queryParams,
      );
      return right(timeSlots);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> rescheduleAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      await remoteDataSource.rescheduleAppointment(queryParams: queryParams);
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      await remoteDataSource.cancelAppointment(queryParams: queryParams);
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      await remoteDataSource.deleteAppointment(queryParams: queryParams);
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, String>> bookAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      final appointmentId = await remoteDataSource.bookAppointment(
        queryParams: queryParams,
      );

      return Right(appointmentId);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> confirmAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      await remoteDataSource.confirmAppointment(queryParams: queryParams);

      return const Right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse>>
  fetchUpcomingAppointments({required PaginationParameters parameters}) async {
    try {
      final response = await remoteDataSource.fetchUpcomingAppointments(
        parameters: parameters,
      );
      //     final List<ClientAppointmentsEntity> entities = response.appointments
      //             .map((model) => model.toEntity())
      //             .toList();
      /*  if (models.appointments.isNotEmpty) {
        return right(null);
      }

      final entities = models.map((model) => model.toEntity()).toList();*/
         
      return right(response);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse>>
  fetchCompletedAppointments({required PaginationParameters parameters}) async {
    try {
      final models = await remoteDataSource.fetchCompletedAppointments(
        parameters: parameters,
      );

      // if (models == null) {
      //   return right(null);
      // }
      //
      // final entities = models.map((model) => model.toEntity()).toList();
      return right(models);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse>>
  fetchCancelledAppointments({required PaginationParameters parameters}) async {
    try {
      final models = await remoteDataSource.fetchCancelledAppointments(

        parameters: parameters,
      );

      // if (models == null) {
      //   return right(null);
      // }
      //
      // final entities = models.map((model) => model.toEntity()).toList();
      return right(models);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
