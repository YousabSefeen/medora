import 'package:dartz/dartz.dart' show Either;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

import '../../../../core/error/failure.dart' show Failure;

abstract class DoctorListRepositoryBase {
  Future<Either<Failure, List<DoctorModel>>> getDoctorsList();
}
