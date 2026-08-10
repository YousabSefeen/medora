import 'package:medora/core/di/injection_container.dart';
import 'package:medora/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:medora/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:medora/features/auth/data/repository/auth_repository_impl.dart';
import 'package:medora/features/auth/domain/repositories/auth_repository.dart';
import 'package:medora/features/auth/domain/use_cases/fetch_email_from_code_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/reset_password_and_sign_in_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/send_password_reset_email_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/verify_otp_and_update_password_use_case.dart';
import 'package:medora/features/auth/domain/use_cases/verify_phone_and_send_otp_use_case.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';

Future<void> initAuthDependencies() async {
  // 1. Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () =>
        AuthRemoteDataSourceImpl(
          firestore: sl(),
          auth: sl(),
          googleSignIn: sl(),
          facebookAuth: sl(),
        ),
  );

  // 2. Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(() => SignInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SignOutUseCase(authRepository: sl()));
  sl.registerLazySingleton(
        () => VerifyPhoneAndSendOtpUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton(
        () => VerifyOtpAndUpdatePasswordUseCase(authRepository: sl()),
  );

  sl.registerLazySingleton(
        () => ResetPasswordAndSignInUseCase(authRepository: sl(),),
  );
  sl.registerLazySingleton(
        () => SendPasswordResetEmailUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton(
        () => FetchEmailFromCodeUseCase(authRepository: sl()),
  );

  // 4. Cubit
  sl.registerLazySingleton(
    () => AuthCubit(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      verifyPhoneAndSendOtpUseCase: sl(),
      verifyOtpAndUpdatePasswordUseCase: sl(),
      sendPasswordResetEmailUseCase: sl(),
      fetchEmailFromCodeUseCase: sl(),
      resetPasswordAndSignInUseCase: sl(),
    ),
  );
}
