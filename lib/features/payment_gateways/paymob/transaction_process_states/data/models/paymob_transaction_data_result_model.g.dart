// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_transaction_data_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobTransactionDataModel _$PaymobTransactionDataResultModelFromJson(
  Map<String, dynamic> json,
) => PaymobTransactionDataModel(
  trnxId: json['id'],
  totalPrice: (double.parse(json['amount_cents']) / 100).toString(),
  success: json['success'],
  is_auth: json['is_auth'],
  is_capture: json['is_capture'],
  is_standalone_payment: json['is_standalone_payment'],
  is_voided: json['is_voided'],
  is_refunded: json['is_refunded'],
  is_3d_secure: json['is_3d_secure'],
  integration_id: json['integration_id'],
  profile_id: json['profile_id'],
  has_parent_transaction: json['has_parent_transaction'],
  orderId: json['order'],
  created_at: json['created_at'],
  currency: json['currency'],
  merchant_commission: json['merchant_commission'],
  discount_details: json['discount_details'],
  is_refund: json['is_refund'],
  error_occured: json['error_occured'],
  refunded_amount_cents: json['refunded_amount_cents'],
  captured_amount: json['captured_amount'],
  is_settled: json['is_settled'],
  bill_balanced: json['bill_balanced'],
  is_bill: json['is_bill'],
  owner: json['owner'],
  merchant_order_id: json['merchant_order_id'],
  dataMessage: json['data.message'],
  sourceType: json['source_data.type'],
  sourceDataPan: json['source_data.pan'],
  sourceSubType: json['source_data.sub_type'],
);
