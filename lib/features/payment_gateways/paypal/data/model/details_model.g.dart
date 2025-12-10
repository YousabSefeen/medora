// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsModel _$DetailsModelFromJson(Map<String, dynamic> json) => DetailsModel(
  subtotal: json['subtotal'] as String,
  shipping: json['shipping'] as String,
  shipping_discount: (json['shipping_discount'] as num).toInt(),
);

Map<String, dynamic> _$DetailsModelToJson(DetailsModel instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'shipping': instance.shipping,
      'shipping_discount': instance.shipping_discount,
    };
