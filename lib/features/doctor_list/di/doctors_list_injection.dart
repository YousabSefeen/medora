




import 'package:medora/features/doctor_list/data/data_source/doctors_list_remote_data_source.dart' show DoctorsListRemoteDataSource;
import 'package:medora/features/doctor_list/data/repository/doctor_list_repository_impl.dart' show DoctorListRepositoryImpl;
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart' show DoctorListRepositoryBase;
import 'package:medora/features/doctor_list/domain/use_cases/get_doctors_list_uc.dart' show GetDoctorsListUC;
import 'package:medora/features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart' show DoctorListCubit;

import '../../../core/di/injection_container.dart' show sl;

Future<void> initDoctorsListDependencies() async {
  // Data Source
  sl.registerLazySingleton<DoctorsListRemoteDataSource>(
        () => DoctorsListRemoteDataSource(),
  );

  // Repository
  sl.registerLazySingleton<DoctorListRepositoryBase>(
        () => DoctorListRepositoryImpl(dataSource: sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => GetDoctorsListUC(repository: sl()));

  // Cubit
  sl.registerFactory(() => DoctorListCubit(useCase: sl()));
}