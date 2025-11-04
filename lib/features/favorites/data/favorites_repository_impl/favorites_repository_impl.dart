import 'dart:io' show HttpException;

import 'package:dartz/dartz.dart';
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/enum/internet_state.dart' show InternetState;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart';
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source.dart'
    show FavoritesRemoteDataSourceBase;
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;

class FavoritesRepositoryImpl extends FavoritesRepositoryBase {

  final FavoritesRemoteDataSourceBase favoritesRemoteDataSourceBase;

  FavoritesRepositoryImpl({
    required this.favoritesRemoteDataSourceBase,

  });

  @override
  Future<Either<Failure, void>> addDoctorToFavorites(String doctorId) async {
    try {
      await favoritesRemoteDataSourceBase.addDoctorToFavorites(doctorId);
      return right(null);

    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getAllFavorites() async {
    try {
      final favorites = await favoritesRemoteDataSourceBase.getAllFavorites();
      return right(favorites);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, Set<String>>> getDoctorFavoriteStatus(
    String doctorId,
  ) async {
    try {
      final doctorFavoriteStatus = await favoritesRemoteDataSourceBase
          .getDoctorFavoriteStatus(doctorId);
      return right(doctorFavoriteStatus);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }

  @override
  Future<Either<Failure, void>> removeDoctorFromFavorites(
    String doctorId,
  ) async {
    try {
      await favoritesRemoteDataSourceBase.removeDoctorFromFavorites(doctorId);
      return right(null);
    } catch (error) {
      return Left(ServerFailure(catchError: error));
    }
  }
}
