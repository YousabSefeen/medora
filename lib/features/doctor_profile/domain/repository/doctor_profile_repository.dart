import 'package:dartz/dartz.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

import '../../../../core/error/failure.dart' show Failure;

abstract class DoctorProfileRepository {
  Future<Either<Failure, void>> uploadDoctorProfile(DoctorEntity doctorProfile);
}
