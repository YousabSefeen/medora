import 'package:dartz/dartz.dart';
import 'package:medora/features/patient/domain/entities/patient_entity.dart'
    show PatientEntity;

import '../../../../core/error/failure.dart';

abstract class PatientRepository {
  Future<Either<Failure, void>> savePatientData(PatientEntity patient);

  Future<Either<Failure, PatientEntity?>> getCachedPatientData();

  Future<Either<Failure, void>> clearCachedPatientData();
}
