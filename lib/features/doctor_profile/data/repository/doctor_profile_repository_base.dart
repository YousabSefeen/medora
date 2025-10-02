import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart' show Failure;
import '../models/doctor_model.dart';


abstract class DoctorProfileRepositoryBase {
  Future<Either<Failure, void>> uploadDoctorProfile(DoctorModel doctorProfile);
}
