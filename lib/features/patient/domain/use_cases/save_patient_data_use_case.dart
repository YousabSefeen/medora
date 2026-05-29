import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/patient/domain/entities/patient_entity.dart'
    show PatientEntity;
import 'package:medora/features/patient/domain/repository/patient_repository.dart'
    show PatientRepository;

class SavePatientDataUseCase extends BaseUseCase<void, PatientEntity> {
  final PatientRepository patientRepository;

  SavePatientDataUseCase({required this.patientRepository});

  @override
  Future<Either<Failure, void>> call(PatientEntity params) async {
    return await patientRepository.savePatientData(params);
  }
}
