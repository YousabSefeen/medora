
import 'package:get_it/get_it.dart';
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source.dart'
    show FavoritesRemoteDataSource;
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source_base.dart'
    show FavoritesRemoteDataSourceBase;
import 'package:medora/features/favorites/data/favorites_repository_impl/favorites_repository_impl.dart';
import 'package:medora/features/favorites/domain/favorites_repository_base/favorites_repository_base.dart'
    show FavoritesRepositoryBase;
import 'package:medora/features/favorites/domain/use_cases/get_favorite_ids_uc.dart'
    show GetFavoriteIdsUc;
import 'package:medora/features/favorites/domain/use_cases/get_favorites_doctors_use_case.dart'
    show GetFavoritesDoctorsUseCase;
import 'package:medora/features/favorites/domain/use_cases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';

import '../../../core/di/injection_container.dart' show sl;


Future<void> initFavoritesDependencies() async {
  // 1. Data Source
  sl.registerLazySingleton<FavoritesRemoteDataSourceBase>(
    () => FavoritesRemoteDataSource(firestore: sl(), userId: sl()),
  );

  // 2. Repository
  sl.registerLazySingleton<FavoritesRepositoryBase>(
    () => FavoritesRepositoryImpl(favoritesRemoteDataSourceBase: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(
    () => GetFavoritesDoctorsUseCase(favoritesRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => ToggleFavoriteUseCase(favoritesRepositoryBase: sl()),
  );
  sl.registerLazySingleton(
    () => GetFavoriteIdsUc(favoritesRepositoryBase: sl()),
  );

  // 4. Cubit
  sl.registerFactory(
    () => FavoritesCubit(
      getFavoritesDoctorsUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      getFavoriteIdsUc: sl(),
    ),
  );
}
