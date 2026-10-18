import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/reviews/domain/entities/updated_doctor_rating.dart';

import '../../../../../core/enum/review_operation.dart';
import '../../../domain/params/add_review_params.dart';
import '../../../domain/params/delete_review_params.dart';
import '../../../domain/params/update_review_params.dart';
import '../../../domain/use_cases/add_review_use_case.dart';
import '../../../domain/use_cases/delete_review_use_case.dart';
import '../../../domain/use_cases/fetch_reviews_use_case.dart';
import '../../../domain/use_cases/fetch_single_review_use_case.dart';
import '../../../domain/use_cases/update_review_use_case.dart';
import '../states/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final FetchReviewsUseCase _fetchReviewsUseCase;
  final AddReviewUseCase _addReviewUseCase;
  final UpdateReviewUseCase _updateReviewUseCase;
  final DeleteReviewUseCase _deleteReviewUseCase;
  final FetchSingleReviewUseCase _fetchSingleReviewUseCase;

  ReviewsCubit({
    required this._fetchReviewsUseCase,
    required this._addReviewUseCase,
    required this._updateReviewUseCase,
    required this._deleteReviewUseCase,
    required this._fetchSingleReviewUseCase,
  }) : super(const ReviewsState());

  Future<void> fetchReviews(String doctorId) async {
    emit(state.copyWith(fetchReviewsStatus: LazyRequestState.loading));

    final result = await _fetchReviewsUseCase(doctorId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          fetchReviewsStatus: LazyRequestState.error,
          fetchReviewsErrorMessage: failure.errorMessage,
        ),
      ),
      (reviews) => emit(
        state.copyWith(
          fetchReviewsStatus: LazyRequestState.loaded,
          reviews: reviews,
        ),
      ),
    );
  }

  Future<void> fetchSingleReview(String reviewId) async {
    emit(state.copyWith(fetchSingleReviewStatus: LazyRequestState.loading));

    final result = await _fetchSingleReviewUseCase(reviewId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          fetchSingleReviewStatus: LazyRequestState.error,
          fetchSingleReviewErrorMessage: failure.errorMessage,
        ),
      ),
      (review) => emit(
        state.copyWith(
          fetchSingleReviewStatus: LazyRequestState.loaded,
          selectedReview: review,
        ),
      ),
    );
  }

  Future<void> addReview(AddReviewParams params) async {
    emit(
      state.copyWith(
        actionStatus: LazyRequestState.loading,
        reviewOperation: ReviewOperation.add,
      ),
    );

    final result = await _addReviewUseCase(params);
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          actionStatus: LazyRequestState.error,
          actionErrorMessage: failure.errorMessage,
        ),
      ),
      (AddReviewResult addReviewResult) => emit(
        state.copyWith(
          actionStatus: LazyRequestState.loaded,
          addReviewResult: addReviewResult,
        ),
      ),
    );
  }

  Future<void> updateReview(UpdateReviewParams params) async {
    emit(
      state.copyWith(
        actionStatus: LazyRequestState.loading,
        reviewOperation: ReviewOperation.update,
      ),
    );

    final result = await _updateReviewUseCase(params);
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          actionStatus: LazyRequestState.error,
          actionErrorMessage: failure.errorMessage,
        ),
      ),
      (UpdatedDoctorRating updatedDoctorRating) => emit(
        state.copyWith(
          actionStatus: LazyRequestState.loaded,
          updatedDoctorRating: updatedDoctorRating,
        ),
      ),
    );
  }

  Future<void> deleteReview(DeleteReviewParams params) async {
    emit(
      state.copyWith(
        actionStatus: LazyRequestState.loading,
        reviewOperation: ReviewOperation.delete,
      ),
    );

    final result = await _deleteReviewUseCase(params);
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          actionStatus: LazyRequestState.error,
          actionErrorMessage: failure.errorMessage,
        ),
      ),
      (UpdatedDoctorRating updatedDoctorRating) => emit(
        state.copyWith(
          actionStatus: LazyRequestState.loaded,
          updatedDoctorRating: updatedDoctorRating,
        ),
      ),
    );
  }

  void resetActionStatus() => emit(
    state.copyWith(
      actionStatus: LazyRequestState.lazy,
      actionErrorMessage: null,
      reviewOperation: ReviewOperation.none,
    ),
  );
}
