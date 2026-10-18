import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/domain/repositories/reviews_repository.dart';

import '../entities/updated_doctor_rating.dart';
import '../params/delete_review_params.dart';

class DeleteReviewUseCase extends BaseUseCase<UpdatedDoctorRating, DeleteReviewParams> {
  final ReviewsRepository _reviewsRepository;

  DeleteReviewUseCase({required this._reviewsRepository});

  @override
  Future<Either<Failure, UpdatedDoctorRating>> call(DeleteReviewParams params) async {
    return await _reviewsRepository.deleteReview(params: params);
  }
}
