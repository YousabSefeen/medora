

import 'package:medora/features/doctor_profile/data/data_source/cloudinary_remote_data_source.dart' show CloudinaryRemoteDataSource;
import 'package:medora/features/doctor_profile/data/data_source/doctor_profile_remote_data_source.dart' show DoctorProfileRemoteDataSource;
import 'package:medora/features/doctor_profile/data/data_source/doctor_profile_remote_data_source_impl.dart' show DoctorProfileRemoteDataSourceImpl;
import 'package:medora/features/doctor_profile/data/repositories/doctor_profile_repository_impl.dart' show DoctorProfileRepositoryImpl;
import 'package:medora/features/doctor_profile/domain/repository/doctor_profile_repository.dart' show DoctorProfileRepository;
import 'package:medora/features/doctor_profile/domain/use_cases/upload_doctor_profile_uc.dart' show UploadDoctorProfileUC;
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart' show DoctorProfileCubit;

import '../../../core/di/injection_container.dart' show sl;

Future<void> initDoctorProfileDependencies() async {
  // Data Sources
  sl.registerFactory(() => CloudinaryRemoteDataSource(sl()));
  sl.registerFactory<DoctorProfileRemoteDataSource>(
        () => DoctorProfileRemoteDataSourceImpl(sl(), sl()),
  );

  // Repository
  sl.registerFactory<DoctorProfileRepository>(
        () => DoctorProfileRepositoryImpl(profileRemoteDataSource: sl()),
  );

  // Use Case
  sl.registerFactory(() => UploadDoctorProfileUC(doctorProfileRepositoryBase: sl()));

  // Cubit
  sl.registerFactory(() => DoctorProfileCubit(uploadProfileUseCase: sl()));
}