import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart'
    show Failure, ServerFailure, LocalFailure;
import 'package:medora/features/appointments/data/data_source/patient_local_data_source.dart';
import 'package:medora/features/appointments/data/models/patient_model.dart'
    show PatientModel;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/entities/patient_entity.dart';
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

import '../../domain/entities/doctor_appointment_entity.dart';
import '../../domain/repository/appointment_repository_base.dart';
import '../data_source/appointment_remote_data_source_base.dart';

class AppointmentRepositoryImpl extends AppointmentRepositoryBase {
  final AppointmentRemoteDataSourceBase remoteDataSource;
  final PatientLocalDataSource patientLocalDataSource;

  AppointmentRepositoryImpl({
    required this.remoteDataSource,
    required this.patientLocalDataSource,
  });

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
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>>
  fetchUpcomingAppointments({required PaginationParameters parameters}) async {
    try {
      final response = await remoteDataSource.fetchUpcomingAppointments(
        parameters: parameters,
      );
      print('length: ${response.list.length}');
      //  print('list: ${response.list[0]}');
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>>
  fetchCompletedAppointments({required PaginationParameters parameters}) async {
    try {
      final response = await remoteDataSource.fetchCompletedAppointments(
        parameters: parameters,
      );
      print('**********************************: ${response.list.length}');

      return right(response);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>>
  fetchCancelledAppointments({required PaginationParameters parameters}) async {
    try {
      final response = await remoteDataSource.fetchCancelledAppointments(
        parameters: parameters,
      );

      return right(response);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, PatientEntity?>> getCachedPatientData() async {
    try {
      final patient = patientLocalDataSource.getCachedPatientData();
      return Right(patient);
    } catch (e) {
      return Left(LocalFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> savePatientData(PatientEntity patient) async {
    try {
      final patientModel = PatientModel.fromEntity(patient);
      await patientLocalDataSource.cachePatientData(patientModel);
      return const Right(null);
    } catch (e) {
      return Left(LocalFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> clearCachedPatientData() async {
    try {
      await patientLocalDataSource.clearCachedPatientData();
      return const Right(null);
    } catch (e) {
      return Left(LocalFailure(catchError: e));
    }
  }
}
