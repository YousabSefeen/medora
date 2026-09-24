import '../../../core/di/injection_container.dart';
import '../data/data_sources/gemini_remote_data_source.dart';
import '../data/repositories/gemini_repository_impl.dart';
import '../domain/repositories/gemini_repository.dart';
import '../domain/use_cases/send_gemini_message_usecase.dart';
import '../presentation/controllers/cubit/gemini_cubit.dart';

Future<void> initGeminiDependencies() async {
  // Data Sources

  sl.registerFactory<GeminiRemoteDataSource>(
    () => GeminiRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerFactory<GeminiRepository>(
    () => GeminiRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Case
  sl.registerFactory(() => SendGeminiMessageUseCase(sl()));

  // Cubit
  sl.registerFactory(() => GeminiCubit(sendGeminiMessageUseCase: sl()));
}
