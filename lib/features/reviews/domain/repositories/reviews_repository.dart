import 'package:dartz/dartz.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';

import '../../../../core/error/failure.dart';
import '../entities/updated_doctor_rating.dart';
import '../params/add_review_params.dart';
import '../params/delete_review_params.dart';
import '../params/update_review_params.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, AddReviewResult>> addReview({required AddReviewParams params});

  Future<Either<Failure, UpdatedDoctorRating>> updateReview({
    required UpdateReviewParams params,
  });
  Future<Either<Failure, UpdatedDoctorRating>> deleteReview({
    required DeleteReviewParams params,
  });
  Future<Either<Failure, List<ReviewEntity>>> fetchReviews({
    required String doctorId,
  });

  Future<Either<Failure, ReviewEntity>> fetchSingleReview({
    required String reviewId,
  });
}
