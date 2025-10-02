import 'package:json_annotation/json_annotation.dart';

import 'amount_model.dart';
import 'item_list_model.dart';

part 'paypal_payment_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PaypalPaymentTransactionModel {
  final String description;
  final AmountModel amount;
  final ItemListModel itemList;

  PaypalPaymentTransactionModel(
      {required this.description,
      required this.amount,
      required this.itemList});

  factory PaypalPaymentTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$PaypalPaymentTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaypalPaymentTransactionModelToJson(this);
}
