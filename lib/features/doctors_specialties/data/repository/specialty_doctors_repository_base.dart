import 'package:dartz/dartz.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;

import '../../../../core/error/failure.dart';


abstract class SpecialtyDoctorsRepositoryBase{


  Future<Either<Failure, List<DoctorModel>>> getDoctorsBySpecialty({
    required String specialtyName,
  });


}