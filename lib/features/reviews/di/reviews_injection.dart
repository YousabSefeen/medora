import 'package:medora/core/di/injection_container.dart';

import '../data/data_sources/reviews_remote_data_source.dart';
import '../data/data_sources/reviews_remote_data_source_impl.dart';
import '../data/repositories/reviews_repository_impl.dart';
import '../domain/repositories/reviews_repository.dart';
import '../domain/use_cases/add_review_use_case.dart';
import '../domain/use_cases/delete_review_use_case.dart';
import '../domain/use_cases/fetch_reviews_use_case.dart';
import '../domain/use_cases/fetch_single_review_use_case.dart';
import '../domain/use_cases/update_review_use_case.dart';
import '../presentation/controller/cubit/reviews_cubit.dart';

Future<void> initReviewsDependencies() async {
  //Reviews
  // 1. Data Source
  sl.registerLazySingleton<ReviewsRemoteDataSource>(
    () => ReviewsRemoteDataSourceImpl(firestore: sl()),
  );

  // 2. Repository
  sl.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepositoryImpl(reviewsRemoteDataSource: sl()),
  );

  // 3. Use Cases
  sl.registerLazySingleton(() => AddReviewUseCase(reviewsRepository: sl()));
  sl.registerLazySingleton(() => UpdateReviewUseCase(reviewsRepository: sl()));
  sl.registerLazySingleton(() => DeleteReviewUseCase(reviewsRepository: sl()));
  sl.registerLazySingleton(() => FetchReviewsUseCase(reviewsRepository: sl()));
  sl.registerLazySingleton(
    () => FetchSingleReviewUseCase(reviewsRepository: sl()),
  );
  // 4. Cubit
  sl.registerLazySingleton(
    () => ReviewsCubit(

      addReviewUseCase: sl(),
      updateReviewUseCase: sl(),
      deleteReviewUseCase: sl(),
      fetchReviewsUseCase: sl(),
      fetchSingleReviewUseCase: sl(),
    ),
  );
}
