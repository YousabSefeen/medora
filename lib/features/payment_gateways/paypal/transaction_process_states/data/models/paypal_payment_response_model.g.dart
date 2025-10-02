// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_payment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaypalPaymentResponseModel _$PaypalPaymentResponseModelFromJson(
        Map<dynamic, dynamic> json) =>
    PaypalPaymentResponseModel(
      error: json['error'] as bool?,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : PaypalDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

PaypalDataModel _$PaypalDataModelFromJson(Map<String, dynamic> json) =>
    PaypalDataModel(
      id: json['id'] as String,
      intent: json['intent'] as String,
      state: json['state'] as String,
      cart: json['cart'] as String,
      payer: PayerModel.fromJson(json['payer'] as Map<String, dynamic>),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PayerModel _$PayerModelFromJson(Map<String, dynamic> json) => PayerModel(
      paymentMethod: json['payment_method'] as String,
      status: json['status'] as String,
      payerInfo:
          PayerInfoModel.fromJson(json['payer_info'] as Map<String, dynamic>),
    );

PayerInfoModel _$PayerInfoModelFromJson(Map<String, dynamic> json) =>
    PayerInfoModel(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      payerId: json['payer_id'] as String,
      shippingAddress: AddressModel.fromJson(
          json['shipping_address'] as Map<String, dynamic>),
    );

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      recipientName: json['recipient_name'] as String,
      line1: json['line1'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postal_code'] as String,
      countryCode: json['country_code'] as String,
    );

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      amount: AmountModel.fromJson(json['amount'] as Map<String, dynamic>),
      payee: PayeeModel.fromJson(json['payee'] as Map<String, dynamic>),
      description: json['description'] as String,
      softDescriptor: json['soft_descriptor'] as String,
    );

AmountModel _$AmountModelFromJson(Map<String, dynamic> json) => AmountModel(
      total: json['total'] as String,
      currency: json['currency'] as String,
    );

PayeeModel _$PayeeModelFromJson(Map<String, dynamic> json) => PayeeModel(
      merchantId: json['merchant_id'] as String,
      email: json['email'] as String,
    );
