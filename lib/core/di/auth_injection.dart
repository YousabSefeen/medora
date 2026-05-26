import 'package:medora/core/di/injection_container.dart';
import 'package:medora/features/auth/data/repository/auth_repository.dart'
    show AuthRepository;
import 'package:medora/features/auth/presentation/controller/cubit/login_cubit.dart'
    show LoginCubit;
import 'package:medora/features/auth/presentation/controller/cubit/register_cubit.dart'
    show RegisterCubit;
import 'package:medora/features/doctors_specialties/data/repository/specialty_doctors_repository.dart'
    show SpecialtyDoctorsRepository;
import 'package:medora/features/doctors_specialties/presentation/controller/cubit/specialty_doctors_cubit.dart'
    show SpecialtyDoctorsCubit;
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart'
    show BottomNavCubit;

Future<void> initAuthDependencies() async {
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());
  sl.registerLazySingleton<SpecialtyDoctorsRepository>(
    () => SpecialtyDoctorsRepository(),
  );

  // Cubits
  sl.registerFactory(() => BottomNavCubit());
  sl.registerFactory(() => LoginCubit(authRepository: sl()));
  sl.registerFactory(() => RegisterCubit(authRepository: sl()));
  sl.registerFactory(
    () => SpecialtyDoctorsCubit(specialtyDoctorsRepository: sl()),
  );
}
