// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  reviewId: json['reviewId'] as String,
  doctorId: json['doctorId'] as String,
  clientId: json['clientId'] as String,
  clientName: json['clientName'] as String,
  clientImage: json['clientImage'] as String,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'doctorId': instance.doctorId,
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'clientImage': instance.clientImage,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
    };
