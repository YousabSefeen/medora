



import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;

abstract class FavoritesRepositoryBase{

  Future<Either<Failure,Set<String>>> isDoctorFavorite(String doctorId );
  Future<Either<Failure,List<DoctorModel>>> getAllFavorites( );
  Future<Either<Failure,void>> addDoctorToFavorites(String doctorId);
  Future<Either<Failure,void>> removeDoctorFromFavorites(String doctorId);

}