import 'package:medora/core/di/injection_container.dart';

import '../data/data_sources/user_remote_data_source.dart';
import '../data/data_sources/user_remote_data_source_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/use_cases/add_user_use_case.dart';
import '../domain/use_cases/get_user_data_use_case.dart';
import '../presentation/controllers/cubit/user_cubit.dart';

Future<void> initUserDependencies() async {
  //User
  // 1. Data Source
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );

  // 2. Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(() => AddUserUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => GetUserDataUseCase(userRepository: sl()));

  // 4. Cubit
  sl.registerLazySingleton(
    () => UserCubit(addUserUseCase: sl(), getUserDataUseCase: sl()),
  );
}
