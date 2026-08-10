import 'package:medora/core/di/injection_container.dart';

import 'package:medora/features/doctors_specialties/data/repository/specialty_doctors_repository.dart'
    show SpecialtyDoctorsRepository;
import 'package:medora/features/doctors_specialties/presentation/controller/cubit/specialty_doctors_cubit.dart'
    show SpecialtyDoctorsCubit;
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart'
    show BottomNavCubit;

Future<void> initYousabDependencies() async {
  // Repositories

  sl.registerLazySingleton<SpecialtyDoctorsRepository>(
    () => SpecialtyDoctorsRepository(),
  );

  // Cubits
  sl.registerFactory(() => BottomNavCubit());

  sl.registerFactory(
    () => SpecialtyDoctorsCubit(specialtyDoctorsRepository: sl()),
  );
}
