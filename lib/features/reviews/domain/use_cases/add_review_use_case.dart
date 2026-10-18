import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/domain/params/add_review_params.dart';
import 'package:medora/features/reviews/domain/repositories/reviews_repository.dart';

import '../entities/updated_doctor_rating.dart';

class AddReviewUseCase extends BaseUseCase<AddReviewResult, AddReviewParams> {
  final ReviewsRepository _reviewsRepository;

  AddReviewUseCase({required this._reviewsRepository});

  @override
  Future<Either<Failure, AddReviewResult>> call(AddReviewParams params) async {
    return await _reviewsRepository.addReview(params: params);
  }
}
