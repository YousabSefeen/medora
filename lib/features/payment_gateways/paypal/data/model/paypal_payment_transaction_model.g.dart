// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_payment_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaypalPaymentTransactionModel _$PaypalPaymentTransactionModelFromJson(
        Map<String, dynamic> json) =>
    PaypalPaymentTransactionModel(
      description: json['description'] as String,
      amount: AmountModel.fromJson(json['amount'] as Map<String, dynamic>),
      itemList:
          ItemListModel.fromJson(json['itemList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaypalPaymentTransactionModelToJson(
        PaypalPaymentTransactionModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'amount': instance.amount.toJson(),
      'itemList': instance.itemList.toJson(),
    };
