import 'package:dartz/dartz.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

import '../../../../core/error/failure.dart';

abstract class SpecialtyDoctorsRepositoryBase {
  Future<Either<Failure, List<DoctorModel>>> getDoctorsBySpecialty({
    required String specialtyName,
  });
}
