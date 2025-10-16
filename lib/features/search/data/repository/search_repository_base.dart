import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;

import '../../../../core/error/failure.dart';

abstract class SearchRepositoryBase {
  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByName({
    required String doctorName,
  });

  Future<Either<Failure, List<DoctorModel>>> searchDoctorsByCriteria({
    required String doctorName,
    required RangeValues priceRange,
    List<String>? specialties,
    String? location,
  });
}
