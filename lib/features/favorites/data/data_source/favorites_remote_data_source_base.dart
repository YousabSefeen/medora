

import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

abstract class FavoritesRemoteDataSourceBase {

  Future<List<String>> getFavoriteIds();
  Future<List<DoctorEntity>> getFavoritesDoctors();

  Future<void> addDoctorToFavorites(String doctorId);

  Future<void> removeDoctorFromFavorites(String doctorId);
}