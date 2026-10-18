import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/reviews/domain/entities/review_entity.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.reviewId,
    required super.doctorId,
    required super.clientId,
    required super.clientName,
    required super.clientImage,
    required super.rating,
    required super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
