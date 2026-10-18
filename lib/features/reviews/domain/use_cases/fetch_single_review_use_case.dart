import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';
import 'package:medora/features/reviews/domain/repositories/reviews_repository.dart';

class FetchSingleReviewUseCase extends BaseUseCase<ReviewEntity, String> {
  final ReviewsRepository reviewsRepository;

  FetchSingleReviewUseCase({required this.reviewsRepository});

  @override
  Future<Either<Failure, ReviewEntity>> call(String reviewId) async {
    return await reviewsRepository.fetchSingleReview(reviewId: reviewId);
  }
}
