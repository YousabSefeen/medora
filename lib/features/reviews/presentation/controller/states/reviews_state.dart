/*
import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';

//enum RequestStatus { initial, loading, success, failure }

class ReviewsState extends Equatable {
  final LazyRequestState fetchDoctorReviewsStatus;
  final List<ReviewEntity> reviews;
  final String? fetchDoctorReviewsErrorMsg;

  final LazyRequestState addReviewStatus;
  final String? addReviewErrorMsg;

  final LazyRequestState updateReviewStatus;
  final String? updateReviewErrorMsg;

  final LazyRequestState fetchReviewByIdStatus;
  final ReviewEntity? review;
  final String? fetchReviewByIdErrorMsg;

  const ReviewsState({
    this.fetchDoctorReviewsStatus = LazyRequestState.lazy,
    this.reviews = const [],
    this.fetchDoctorReviewsErrorMsg,
    this.addReviewStatus =  LazyRequestState.lazy,
    this.addReviewErrorMsg,
    this.updateReviewStatus = LazyRequestState.lazy,
    this.updateReviewErrorMsg,
    this.fetchReviewByIdStatus =  LazyRequestState.lazy,
    this.review,
    this.fetchReviewByIdErrorMsg,
  });

  ReviewsState copyWith({
    LazyRequestState? fetchDoctorReviewsStatus,
    List<ReviewEntity>? reviews,
    String? fetchDoctorReviewsErrorMsg,
    LazyRequestState? addReviewStatus,
    String? addReviewErrorMsg,
    LazyRequestState? updateReviewStatus,
    String? updateReviewErrorMsg,
    LazyRequestState? fetchReviewByIdStatus,
    ReviewEntity? review,
    String? fetchReviewByIdErrorMsg,
  }) {
    return ReviewsState(
      fetchDoctorReviewsStatus:
      fetchDoctorReviewsStatus ?? this.fetchDoctorReviewsStatus,
      reviews: reviews ?? this.reviews,
      fetchDoctorReviewsErrorMsg:
      fetchDoctorReviewsErrorMsg ?? this.fetchDoctorReviewsErrorMsg,
      addReviewStatus: addReviewStatus ?? this.addReviewStatus,
      addReviewErrorMsg: addReviewErrorMsg ?? this.addReviewErrorMsg,
      updateReviewStatus: updateReviewStatus ?? this.updateReviewStatus,
      updateReviewErrorMsg: updateReviewErrorMsg ?? this.updateReviewErrorMsg,
      fetchReviewByIdStatus:
      fetchReviewByIdStatus ?? this.fetchReviewByIdStatus,
      review: review ?? this.review,
      fetchReviewByIdErrorMsg:
      fetchReviewByIdErrorMsg ?? this.fetchReviewByIdErrorMsg,
    );
  }

  @override
  List<Object?> get props => [
    fetchDoctorReviewsStatus,
    fetchDoctorReviewsErrorMsg,
    reviews,
    addReviewStatus,
    addReviewErrorMsg,
    updateReviewStatus,
    updateReviewErrorMsg,
    fetchReviewByIdStatus,
    fetchReviewByIdErrorMsg,
    review,
  ];
}*/
import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';

import '../../../../../core/enum/review_operation.dart';
import '../../../domain/entities/updated_doctor_rating.dart';

class ReviewsState extends Equatable {
  // Fetch Reviews List
  final ReviewOperation reviewOperation;
  final LazyRequestState fetchReviewsStatus;
  final List<ReviewEntity> reviews;
  final String? fetchReviewsErrorMessage;

  // Fetch Single Review
  final LazyRequestState fetchSingleReviewStatus;
  final ReviewEntity? selectedReview;
  final String? fetchSingleReviewErrorMessage;

  // Mutations (Add, Update, Delete)
  final LazyRequestState actionStatus;
  final String? actionErrorMessage;
  final AddReviewResult? addReviewResult;
  final UpdatedDoctorRating? updatedDoctorRating;

  const ReviewsState({
    this.reviewOperation = ReviewOperation.none,
    this.fetchReviewsStatus = LazyRequestState.lazy,
    this.reviews = const [],
    this.fetchReviewsErrorMessage,
    this.fetchSingleReviewStatus = LazyRequestState.lazy,
    this.selectedReview,
    this.fetchSingleReviewErrorMessage,
    this.actionStatus = LazyRequestState.lazy,
    this.actionErrorMessage,
    this.addReviewResult,
    this.updatedDoctorRating,
  });

  ReviewsState copyWith({
    ReviewOperation? reviewOperation,
    LazyRequestState? fetchReviewsStatus,
    List<ReviewEntity>? reviews,
    String? fetchReviewsErrorMessage,
    LazyRequestState? fetchSingleReviewStatus,
    ReviewEntity? selectedReview,
    String? fetchSingleReviewErrorMessage,
    LazyRequestState? actionStatus,
    String? actionErrorMessage,
    AddReviewResult? addReviewResult,
    UpdatedDoctorRating? updatedDoctorRating,
  }) {
    return ReviewsState(
      reviewOperation: reviewOperation ?? this.reviewOperation,
      fetchReviewsStatus: fetchReviewsStatus ?? this.fetchReviewsStatus,
      reviews: reviews ?? this.reviews,
      fetchReviewsErrorMessage:
          fetchReviewsErrorMessage ?? this.fetchReviewsErrorMessage,
      fetchSingleReviewStatus:
          fetchSingleReviewStatus ?? this.fetchSingleReviewStatus,
      selectedReview: selectedReview ?? this.selectedReview,
      fetchSingleReviewErrorMessage:
          fetchSingleReviewErrorMessage ?? this.fetchSingleReviewErrorMessage,
      actionStatus: actionStatus ?? this.actionStatus,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
      addReviewResult: addReviewResult ?? this.addReviewResult,
      updatedDoctorRating: updatedDoctorRating ?? this.updatedDoctorRating,
    );
  }

  @override
  List<Object?> get props => [
    reviewOperation,
    fetchReviewsStatus,
    reviews,
    fetchReviewsErrorMessage,
    fetchSingleReviewStatus,
    selectedReview,
    fetchSingleReviewErrorMessage,
    actionStatus,
    actionErrorMessage,
    addReviewResult,
    updatedDoctorRating,
  ];
}
