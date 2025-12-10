import 'package:json_annotation/json_annotation.dart';

part 'paypal_payment_response_model.g.dart';

@JsonSerializable()
class PaypalPaymentResponseModel {
  final bool? error;
  final String message;
  final PaypalDataModel? data;

  PaypalPaymentResponseModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory PaypalPaymentResponseModel.fromJson(Map<dynamic, dynamic> json) =>
      _$PaypalPaymentResponseModelFromJson(json);
}

@JsonSerializable()
class PaypalDataModel {
  final String id;
  final String intent;
  final String state;
  final String cart;
  final PayerModel payer;
  final List<TransactionModel> transactions;

  PaypalDataModel({
    required this.id,
    required this.intent,
    required this.state,
    required this.cart,
    required this.payer,
    required this.transactions,
  });

  factory PaypalDataModel.fromJson(Map<String, dynamic> json) =>
      _$PaypalDataModelFromJson(json);
}

@JsonSerializable()
class PayerModel {
  final String paymentMethod;
  final String status;
  final PayerInfoModel payerInfo;

  PayerModel({
    required this.paymentMethod,
    required this.status,
    required this.payerInfo,
  });

  factory PayerModel.fromJson(Map<String, dynamic> json) =>
      _$PayerModelFromJson(json);
}

@JsonSerializable()
class PayerInfoModel {
  final String email;
  final String firstName;
  final String lastName;
  final String payerId;
  final AddressModel shippingAddress;

  PayerInfoModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.payerId,
    required this.shippingAddress,
  });

  factory PayerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PayerInfoModelFromJson(json);
}

@JsonSerializable()
class AddressModel {
  final String recipientName;
  final String line1;
  final String city;
  final String state;
  final String postalCode;
  final String countryCode;

  AddressModel({
    required this.recipientName,
    required this.line1,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.countryCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@JsonSerializable()
class TransactionModel {
  final AmountModel amount;
  final PayeeModel payee;
  final String description;
  final String softDescriptor;

  TransactionModel({
    required this.amount,
    required this.payee,
    required this.description,
    required this.softDescriptor,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@JsonSerializable()
class AmountModel {
  final String total;
  final String currency;

  AmountModel({required this.total, required this.currency});

  factory AmountModel.fromJson(Map<String, dynamic> json) =>
      _$AmountModelFromJson(json);
}

@JsonSerializable()
class PayeeModel {
  final String merchantId;
  final String email;

  PayeeModel({required this.merchantId, required this.email});

  factory PayeeModel.fromJson(Map<String, dynamic> json) =>
      _$PayeeModelFromJson(json);
}
