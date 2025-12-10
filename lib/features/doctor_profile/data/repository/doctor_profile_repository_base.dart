import 'package:dartz/dartz.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

import '../../../../core/error/failure.dart' show Failure;

abstract class DoctorProfileRepositoryBase {
  Future<Either<Failure, void>> uploadDoctorProfile(DoctorModel doctorProfile);
}
