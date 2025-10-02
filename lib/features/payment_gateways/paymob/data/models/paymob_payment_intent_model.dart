

import 'package:json_annotation/json_annotation.dart';
import 'package:medora/features/payment_gateways/paymob/data/models/paymob_billing_data_model.dart' show PaymobBillingDataModel;
import 'package:medora/features/payment_gateways/paymob/data/models/paymob_item_model.dart' show PaymobItemModel;


part 'paymob_payment_intent_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymobPaymentIntentModel {
  final int amount;
  final String currency;
  final List<dynamic> payment_methods;
  final List<PaymobItemModel> items;
  final PaymobBillingDataModel billing_data;
  final String special_reference;
  final int expiration;
  final String notification_url;
  final String redirection_url;

  PaymobPaymentIntentModel({
    required this.amount,
    required this.currency,
    required this.payment_methods,
    required this.items,
    required this.billing_data,
    required this.special_reference,
    required this.expiration,
    required this.notification_url,
    required this.redirection_url,
  });

  factory PaymobPaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymobPaymentIntentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymobPaymentIntentModelToJson(this);
}
