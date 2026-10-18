import '../../../core/di/injection_container.dart' show sl;
import '../data/data_sources/specialties_local_data_source.dart';
import '../data/data_sources/specialties_remote_data_source.dart';
import '../data/repositories/specialties_repository_impl.dart';
import '../domain/repositories/specialties_repository.dart';
import '../domain/use_cases/fetch_all_specialties_use_case.dart';
import '../domain/use_cases/fetch_top_specialties_use_case.dart';
import '../domain/use_cases/fetch_doctors_by_specialty_use_case.dart';
import '../presentation/controller/cubit/specialties_cubit.dart';
import '../presentation/controller/cubit/specialty_doctors_cubit.dart';

Future<void> initSpecialtiesDependencies() async {
  // // 1. Data Source
  sl.registerLazySingleton<SpecialtiesRemoteDataSource>(
    () => SpecialtiesRemoteDataSourceImpl(firestore: sl()),
  );
  // 1. Data Source
  sl.registerLazySingleton<SpecialtiesLocalDataSource>(
    () => SpecialtiesLocalDataSourceImpl(),
  );
  // 2. Repository
  sl.registerLazySingleton<SpecialtiesRepository>(
    () => SpecialtiesRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // 3. Use Cases
  sl.registerLazySingleton(
    () => FetchAllSpecialtiesUseCase(specialtiesRepository: sl()),
  );
  sl.registerLazySingleton(
    () => FetchTopSpecialtiesUseCase(specialtiesRepository: sl()),
  );

  // sl.registerLazySingleton(
  //       () => GetFavoriteIdsUseCase(favoritesRepository: sl()),
  // );

  // 4. Cubit
  sl.registerFactory(
    () => SpecialtiesCubit(
      fetchAllSpecialtiesUseCase: sl(),
      fetchTopSpecialtiesUseCase: sl(),
    ),
  );

  // Register Factory with Parameter for Specialty Name
  sl.registerFactoryParam<SpecialtyDoctorsCubit, String, void>(
    (specialtyName, _) => SpecialtyDoctorsCubit(
      specialtyName: specialtyName,
      getDoctorsBySpecialtyUseCase: GetDoctorsBySpecialtyUseCase(
        specialtiesRepository: sl(),
        specialtyName: specialtyName,
      ),
    ),
  );
}
