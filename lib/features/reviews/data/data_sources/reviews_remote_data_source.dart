import 'package:medora/features/reviews/data/models/review_model.dart';

import '../../domain/entities/updated_doctor_rating.dart';
import '../../domain/params/add_review_params.dart';
import '../../domain/params/delete_review_params.dart';
import '../../domain/params/update_review_params.dart';

abstract class ReviewsRemoteDataSource {
  Future<AddReviewResult> addReview({required AddReviewParams params});

  Future<UpdatedDoctorRating> updateReview({required UpdateReviewParams params});
  Future<UpdatedDoctorRating> deleteReview({required DeleteReviewParams params});

  Future<List<ReviewModel>> fetchReviews({required String doctorId});

  Future<ReviewModel> fetchSingleReview({required String reviewId});
}
