import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

abstract class FavoritesRepositoryBase {
  Future<Either<Failure, bool>> isDoctorFavorite(String doctorId);

  Future<Either<Failure, List<DoctorModel>>> getFavoritesDoctors();

  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId);

  Future<Either<Failure, void>> removeDoctorFromFavorites(String doctorId);
}
