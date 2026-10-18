class UpdateReviewParams {
  final String reviewId;
  final String appointmentId;
  final String doctorId;
  final double oldRating;
  final double newRating;
  final String newComment;

  const UpdateReviewParams({
    required this.reviewId,
    required this.appointmentId,
    required this.doctorId,
    required this.oldRating,
    required this.newRating,
    required this.newComment,
  });
}
