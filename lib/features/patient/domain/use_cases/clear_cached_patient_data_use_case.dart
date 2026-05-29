import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/patient/domain/repository/patient_repository.dart'
    show PatientRepository;

class ClearCachedPatientDataUseCase extends BaseUseCase<void, NoParams> {
  final PatientRepository patientRepository;

  ClearCachedPatientDataUseCase({required this.patientRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await patientRepository.clearCachedPatientData();
  }
}
