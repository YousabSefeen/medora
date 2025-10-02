// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_payment_intent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobPaymentIntentModel _$PaymobPaymentIntentModelFromJson(
        Map<String, dynamic> json) =>
    PaymobPaymentIntentModel(
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String,
      payment_methods: json['payment_methods'] as List<dynamic>,
      items: (json['items'] as List<dynamic>)
          .map((e) => PaymobItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      billing_data: PaymobBillingDataModel.fromJson(
          json['billing_data'] as Map<String, dynamic>),
      special_reference: json['special_reference'] as String,
      expiration: (json['expiration'] as num).toInt(),
      notification_url: json['notification_url'] as String,
      redirection_url: json['redirection_url'] as String,
    );

Map<String, dynamic> _$PaymobPaymentIntentModelToJson(
        PaymobPaymentIntentModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'payment_methods': instance.payment_methods,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'billing_data': instance.billing_data.toJson(),
      'special_reference': instance.special_reference,
      'expiration': instance.expiration,
      'notification_url': instance.notification_url,
      'redirection_url': instance.redirection_url,
    };
