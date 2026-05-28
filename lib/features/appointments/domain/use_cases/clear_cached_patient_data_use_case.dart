import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;

class ClearCachedPatientDataUseCase extends BaseUseCase<void, NoParams> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  ClearCachedPatientDataUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await appointmentRepositoryBase.clearCachedPatientData();
  }
}
