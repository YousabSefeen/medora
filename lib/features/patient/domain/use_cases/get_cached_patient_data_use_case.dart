import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/patient/domain/entities/patient_entity.dart'
    show PatientEntity;
import 'package:medora/features/patient/domain/repository/patient_repository.dart'
    show PatientRepository;

class GetCachedPatientDataUseCase
    extends BaseUseCase<PatientEntity?, NoParams> {
  final PatientRepository patientRepository;

  GetCachedPatientDataUseCase({required this.patientRepository});

  @override
  Future<Either<Failure, PatientEntity?>> call(NoParams email) async {
    return await patientRepository.getCachedPatientData();
  }
}
