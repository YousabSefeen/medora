import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/domain/repositories/reviews_repository.dart';

import '../entities/updated_doctor_rating.dart';
import '../params/update_review_params.dart';

class UpdateReviewUseCase extends BaseUseCase<UpdatedDoctorRating, UpdateReviewParams> {
  final ReviewsRepository reviewsRepository;

  UpdateReviewUseCase({required this.reviewsRepository});

  @override
  Future<Either<Failure, UpdatedDoctorRating>> call(UpdateReviewParams params) async {
    return await reviewsRepository.updateReview(params: params);
  }
}
