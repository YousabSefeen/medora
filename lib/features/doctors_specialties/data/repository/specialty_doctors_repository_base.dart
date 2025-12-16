import 'package:dartz/dartz.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

import '../../../../core/error/failure.dart';

abstract class SpecialtyDoctorsRepositoryBase {
  Future<Either<Failure, List<DoctorEntity>>> getDoctorsBySpecialty({
    required String specialtyName,
  });
}
