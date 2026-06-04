import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source.dart'
    show FavoritesRemoteDataSource;
import 'package:medora/features/favorites/data/data_source/favorites_remote_data_source_impl.dart'
    show FavoritesRemoteDataSourceImpl;
import 'package:medora/features/favorites/data/repositories/favorites_repository_impl.dart'
    show FavoritesRepositoryImpl;
import 'package:medora/features/favorites/domain/repositories/favorites_repository.dart'
    show FavoritesRepository;
import 'package:medora/features/favorites/domain/usecases/get_favorite_ids_use_case.dart'
    show GetFavoriteIdsUseCase;
import 'package:medora/features/favorites/domain/usecases/get_favorites_doctors_use_case.dart'
    show GetFavoritesDoctorsUseCase;
import 'package:medora/features/favorites/domain/usecases/toggle_favorite_use_case.dart'
    show ToggleFavoriteUseCase;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';

import '../../../core/di/injection_container.dart' show sl;

Future<void> initFavoritesDependencies() async {
  // 1. Data Source
  sl.registerLazySingleton<FavoritesRemoteDataSource>(
    () => FavoritesRemoteDataSourceImpl(firestore: sl(), userId: sl()),
  );

  // 2. Repository
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(favoritesRemoteDataSource: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(
    () => GetFavoritesDoctorsUseCase(favoritesRepository: sl()),
  );
  sl.registerLazySingleton(
    () => ToggleFavoriteUseCase(favoritesRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetFavoriteIdsUseCase(favoritesRepository: sl()),
  );

  // 4. Cubit
  sl.registerLazySingleton(
    () => FavoritesCubit(
      getFavoriteIdsUseCase: sl(),
      getFavoritesDoctorsUseCase: sl(),
      toggleFavoriteUseCase: sl(),
    ),
  );
}
