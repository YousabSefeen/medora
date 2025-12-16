import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';

import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

abstract class FavoritesRepositoryBase {
  Future<Either<Failure, bool>> isDoctorFavorite(String doctorId);

  Future<Either<Failure, List<DoctorEntity>>> getFavoritesDoctors();

  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId);

  Future<Either<Failure, void>> removeDoctorFromFavorites(String doctorId);
}
