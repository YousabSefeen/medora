import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/entities/doctor_appointment_entity.dart'
    show DoctorAppointmentEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart';

class FetchDoctorAppointmentsUseCase
    extends BaseUseCase<List<DoctorAppointmentEntity>, String> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  FetchDoctorAppointmentsUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, List<DoctorAppointmentEntity>>> call(
    String params,
  ) async {
    return await appointmentRepositoryBase.fetchDoctorAppointments(
      doctorId: params,
    );
  }
}
