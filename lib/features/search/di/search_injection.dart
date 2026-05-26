



import 'package:medora/features/search/data/data_sources/search_remote_data_source.dart' show SearchRemoteDataSourceBase, SearchRemoteDataSource;
import 'package:medora/features/search/data/repository/search_repository_impl.dart' show SearchRepositoryImpl;
import 'package:medora/features/search/domain/search_repository_base/search_repository_base.dart' show SearchRepositoryBase;
import 'package:medora/features/search/domain/use_cases/search_doctors_by_criteria_use_case.dart' show SearchDoctorsByCriteriaUseCase;
import 'package:medora/features/search/domain/use_cases/search_doctors_by_name_use_case.dart' show SearchDoctorsByNameUseCase;
import 'package:medora/features/search/presentation/controller/cubit/home_doctor_search_cubit.dart' show HomeDoctorSearchCubit;

import '../../../core/di/injection_container.dart' show sl;

Future<void> initSearchDependencies() async {
  // Data Source
  sl.registerLazySingleton<SearchRemoteDataSourceBase>(
        () => SearchRemoteDataSource(),
  );

  // Repository
  sl.registerLazySingleton<SearchRepositoryBase>(
        () => SearchRepositoryImpl(dataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => SearchDoctorsByNameUseCase(searchRepositoryBase: sl()));
  sl.registerLazySingleton(() => SearchDoctorsByCriteriaUseCase(searchRepositoryBase: sl()));

  // Cubit
  sl.registerFactory(() => HomeDoctorSearchCubit(searchByName: sl()));
}