// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobItemModel _$PaymobItemModelFromJson(Map<String, dynamic> json) =>
    PaymobItemModel(
      name: json['name'] as String,
      amount: (json['amount'] as num).toInt(),
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$PaymobItemModelToJson(PaymobItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'description': instance.description,
      'quantity': instance.quantity,
    };
