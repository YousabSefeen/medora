import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String reviewId;
  final String doctorId;
  final String clientId;
  final String clientName;
  final String  clientImage;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const ReviewEntity({
    required this.reviewId,
    required this.doctorId,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    reviewId,
    doctorId,
    clientId,
    clientName,
    clientImage,
    rating,
    comment,
    createdAt,
  ];
}
