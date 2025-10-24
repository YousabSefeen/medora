



import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';

abstract class FavoritesRepositoryBase{

  Future<Either<Failure,Set<String>>> isDoctorFavorite(String doctorId );
  Future<Either<Failure,List<String>>> getFavorites( );
  Future<Either<Failure,void>> addDoctorToFavorites(String doctorId);
  Future<Either<Failure,void>> removeDoctorFromFavorites(String doctorId);

}