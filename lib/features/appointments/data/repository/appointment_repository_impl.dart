import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart' show Failure, ServerFailure;
import 'package:medora/features/appointments/domain/use_cases/fetch_booked_time_slots_use_case.dart'
    show FetchBookedTimeSlotsParams;

import '../../domain/entities/book_appointment_entity.dart';
import '../../domain/entities/client_appointments_entity.dart';
import '../../domain/entities/doctor_appointment_entity.dart';
import '../../domain/repository/appointment_repository_base.dart';
import '../data_source/appointment_remote_data_source_base.dart';
import '../models/book_appointment_model.dart';

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
      final timeSlots = await remoteDataSource
          .fetchBookedTimeSlots(
        queryParams: queryParams,
          );
      return right(timeSlots);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> bookAppointment({
    required String doctorId,
    required BookAppointmentEntity bookAppointmentEntity,
  }) async {
    try {
      final bookAppointmentModel = BookAppointmentModel.fromEntity(
        bookAppointmentEntity,
      );

      await remoteDataSource.bookAppointment(
        doctorId: doctorId,
        bookAppointmentModel: bookAppointmentModel,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> rescheduleAppointment({
    required Map<String, dynamic> queryParams,
  }) async {
    try {
      await remoteDataSource.rescheduleAppointment(
    queryParams: queryParams,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment({
    required String doctorId,
    required String appointmentId,
  }) async {
    try {
      await remoteDataSource.cancelAppointment(
        doctorId: doctorId,
        appointmentId: appointmentId,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, List<ClientAppointmentsEntity>?>>
  fetchClientAppointments() async {
    try {
      final models = await remoteDataSource
          .fetchClientAppointments();

      if (models == null) {
        return right(null);
      }

      final entities = models.map((model) => model.toEntity()).toList();
      return right(entities);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAppointment({
    required String appointmentId,
    required String doctorId,
  }) async {
    try {
      await remoteDataSource.deleteAppointment(
        appointmentId: appointmentId,
        doctorId: doctorId,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
