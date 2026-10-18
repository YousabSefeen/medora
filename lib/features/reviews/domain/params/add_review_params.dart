class AddReviewParams {
  final String appointmentId;
  final String doctorId;
  final String clientId;
  final String clientName;
  final String clientImage;
  final double rating;
  final String comment;

  const AddReviewParams({
    required this.appointmentId,
    required this.doctorId,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.rating,
    required this.comment,
  });
}
