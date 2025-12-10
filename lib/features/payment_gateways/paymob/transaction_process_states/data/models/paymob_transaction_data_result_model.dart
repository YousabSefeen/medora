import 'package:json_annotation/json_annotation.dart';

part 'paymob_transaction_data_result_model.g.dart';

@JsonSerializable()
class PaymobTransactionDataModel {
  ///1. الأساسية المتعلقة بالمعاملة (Transaction):
  //id: رقم تعريف المعاملة (Transaction ID)، يعتبر أساسيًا لتتبع المعاملة.
  final String? trnxId;

  // amountCents: قيمة المبلغ بالقرش، وهي أهم جزء عند التعامل مع المدفوعات.
  final String? totalPrice;

  // success: حالة نجاح المعاملة (true/false)، لمعرفة ما إذا كانت قد تمت بنجاح.

  final String? success;

  // currency: العملة المستخدمة في المعاملة (مثل: EGP).
  final String? currency;

  //isAuth: تشير إلى ما إذا كانت المعاملة مصرح بها.
  final String? is_auth;

  //isCapture: لتحديد إذا تم الاستحواذ على المبلغ من الحساب.
  final String? is_capture;

  ///4. التحقق والأمان:

  //is3dSecure: يشير إلى إذا كانت المعاملة تتبع بروتوكول 3D Secure، وهو ضروري للأمان.
  final String? is_3d_secure;

  ///5. المبلغ والحالة:

  //isVoided: إذا كانت المعاملة ملغاة.
  final String? is_voided;

  //  isRefunded: إذا كانت المعاملة مستردة.
  final String? is_refunded;

  // capturedAmount: المبلغ الذي تم استحواذه بالفعل.
  final String? captured_amount;

  //refundedAmountCents: المبلغ المسترد، إذا تم إرجاع أي أموال.
  final String? refunded_amount_cents;

  //**************
  ///6. التحكم والتخصيص:

  // merchantOrderId: رقم تعريف الطلب من التاجر، يُستخدم لمطابقة الطلب مع النظام الداخلي للتاجر.
  final String? merchant_order_id;

  //integrationId: رقم تعريف التكامل، يربط المعاملة بمصدرها (مثل: API).
  final String? integration_id;

  // profileId: ملف تعريف المستخدم الذي أجرى المعاملة.
  final String? profile_id;

  //*************
  final String? is_standalone_payment;

  final String? has_parent_transaction;
  final String? orderId;

  //createdAt: تاريخ ووقت إنشاء المعاملة.
  final String? created_at;

  final String? merchant_commission;
  final String?
  discount_details; // يمكن استخدام List<Map<String?, dynamic>> عند الحاجة

  final String? is_refund;
  final String? error_occured;

  final String? is_settled;
  final String? bill_balanced;
  final String? is_bill;
  final String? owner;

  final String? dataMessage; //dataMessage 'data.message=Approved'
  final String? sourceType; //sourceType: نوع مصدر الدفع (مثل: بطاقة، بنك، إلخ).
  final String?
  sourceDataPan; //sourceDataPan: رقم البطاقة المقصوص (آخر 4 أرقام).
  final String?
  sourceSubType; //sourceSubType: نوع البطاقة (مثل: MasterCard، Visa).

  PaymobTransactionDataModel({
    required this.trnxId,
    required this.totalPrice,
    required this.success,
    required this.is_auth,
    required this.is_capture,
    required this.is_standalone_payment,
    required this.is_voided,
    required this.is_refunded,
    required this.is_3d_secure,
    required this.integration_id,
    required this.profile_id,
    required this.has_parent_transaction,
    required this.orderId,
    required this.created_at,
    required this.currency,
    required this.merchant_commission,
    required this.discount_details,
    required this.is_refund,
    required this.error_occured,
    required this.refunded_amount_cents,
    required this.captured_amount,
    required this.is_settled,
    required this.bill_balanced,
    required this.is_bill,
    required this.owner,
    required this.merchant_order_id,
    required this.dataMessage,
    required this.sourceType,
    required this.sourceDataPan,
    required this.sourceSubType,
  });

  factory PaymobTransactionDataModel.fromJson(Map<String, dynamic> json) =>
      _$PaymobTransactionDataResultModelFromJson(json);
}
