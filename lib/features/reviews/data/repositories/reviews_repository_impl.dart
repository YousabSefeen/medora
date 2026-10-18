import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/data/data_sources/reviews_remote_data_source.dart';
import 'package:medora/features/reviews/data/models/review_model.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';
import 'package:medora/features/reviews/domain/params/delete_review_params.dart';
import 'package:medora/features/reviews/domain/params/update_review_params.dart';
import 'package:medora/features/reviews/domain/repositories/reviews_repository.dart';

import '../../domain/entities/updated_doctor_rating.dart';
import '../../domain/params/add_review_params.dart';

class ReviewsRepositoryImpl extends ReviewsRepository {
  final ReviewsRemoteDataSource _reviewsRemoteDataSource;

  ReviewsRepositoryImpl({required this._reviewsRemoteDataSource});

  @override
  Future<Either<Failure, AddReviewResult>> addReview({
    required AddReviewParams params,
  }) async {
    try {
      final addReviewResult = await _reviewsRemoteDataSource.addReview(params: params);
      return Right(addReviewResult);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, UpdatedDoctorRating>> updateReview({
    required UpdateReviewParams params,
  }) async {
    try {
      final updatedDoctorRating = await _reviewsRemoteDataSource.updateReview(
        params: params,
      );
      return Right(updatedDoctorRating);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, UpdatedDoctorRating>> deleteReview({
    required DeleteReviewParams params,
  }) async {
    try {
      final updatedDoctorRating = await _reviewsRemoteDataSource.deleteReview(
        params: params,
      );
      return Right(updatedDoctorRating);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> fetchReviews({
    required String doctorId,
  }) async {
    try {
      final List<ReviewModel> models = await _reviewsRemoteDataSource
          .fetchReviews(doctorId: doctorId);

      return right(models);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, ReviewEntity>> fetchSingleReview({
    required String reviewId,
  }) async {
    try {
      final models = await _reviewsRemoteDataSource.fetchSingleReview(
        reviewId: reviewId,
      );

      return right(models);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
