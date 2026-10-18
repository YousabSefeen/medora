import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';
import 'package:medora/features/reviews/domain/repositories/reviews_repository.dart';

class FetchReviewsUseCase extends BaseUseCase<List<ReviewEntity>, String> {
  final ReviewsRepository reviewsRepository;

  FetchReviewsUseCase({required this.reviewsRepository});

  @override
  Future<Either<Failure, List<ReviewEntity>>> call(String doctorId) async {
    return await reviewsRepository.fetchReviews(doctorId: doctorId);
  }
}
