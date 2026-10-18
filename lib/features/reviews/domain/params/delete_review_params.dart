class DeleteReviewParams {
  final String reviewId;
  final String appointmentId;
  final String doctorId;
  final double ratingToDelete;

  const DeleteReviewParams({
    required this.reviewId,
    required this.appointmentId,
    required this.doctorId,
    required this.ratingToDelete,
  });
}
