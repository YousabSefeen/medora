import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/entities/patient_entity.dart'
    show PatientEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class GetCachedPatientDataUseCase extends BaseUseCase<PatientEntity?, NoParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  GetCachedPatientDataUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, PatientEntity?>> call(NoParams params ) async {
    return await appointmentRepositoryBase.getCachedPatientData( );
  }
}
