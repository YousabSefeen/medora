import 'package:medora/features/patient/data/data_sources/patient_local_data_source.dart'
    show PatientLocalDataSource, PatientLocalDataSourceImpl;
import 'package:medora/features/patient/data/repositories/patient_repository_impl.dart'
    show PatientRepositoryImpl;
import 'package:medora/features/patient/domain/repository/patient_repository.dart'
    show PatientRepository;
import 'package:medora/features/patient/domain/use_cases/get_cached_patient_data_use_case.dart'
    show GetCachedPatientDataUseCase;
import 'package:medora/features/patient/domain/use_cases/save_patient_data_use_case.dart'
    show SavePatientDataUseCase;
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart'
    show PatientCubit;

import '../../../core/di/injection_container.dart' show sl;

Future<void> initPatientDependencies() async {
  // 1. Data Source

  sl.registerLazySingleton<PatientLocalDataSource>(
    () => PatientLocalDataSourceImpl(sl()),
  );
  // 2. Repository
  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(patientLocalDataSource: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(
    () => SavePatientDataUseCase(patientRepository: sl()),
  );
  sl.registerLazySingleton(
    () => GetCachedPatientDataUseCase(patientRepository: sl()),
  );

  // 4. Cubits

  sl.registerFactory<PatientCubit>(
    () => PatientCubit(
      savePatientDataUseCase: sl(),
      getCachedPatientDataUseCase: sl(),
    ),
  );
}
