import 'package:medora/features/doctor_list/data/data_sources/doctors_list_remote_data_source.dart'
    show DoctorsListRemoteDataSource;
import 'package:medora/features/doctor_list/data/data_sources/doctors_list_remote_data_source_impl.dart'
    show DoctorsListRemoteDataSourceImpl;
import 'package:medora/features/doctor_list/data/repositories/doctors_list_repository_impl.dart'
    show DoctorsListRepositoryImpl;
import 'package:medora/features/doctor_list/domain/repositories/doctors_list_repository.dart'
    show DoctorsListRepository;
import 'package:medora/features/doctor_list/domain/use_cases/fetch_doctors_list_use_case.dart'
    show FetchDoctorsListUseCase;
import 'package:medora/features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart'
    show DoctorListCubit;

import '../../../core/di/injection_container.dart' show sl;

Future<void> initDoctorsListDependencies() async {
  // Data Source
  sl.registerLazySingleton<DoctorsListRemoteDataSource>(
    () => DoctorsListRemoteDataSourceImpl(firestore: sl()),
  );

  // Repository
  sl.registerLazySingleton<DoctorsListRepository>(
    () => DoctorsListRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => FetchDoctorsListUseCase(repository: sl()));

  // Cubit
  sl.registerFactory(() => DoctorListCubit(useCase: sl()));
}
