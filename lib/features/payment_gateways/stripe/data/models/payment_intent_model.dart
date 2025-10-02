class PaymentIntentModel {
  final int amount;
  final String currency;
  final String customerId;
  final String? clientSecret;
  final String? paymentMethod;

  PaymentIntentModel(
      {required this.currency,
      required this.amount,
      this.clientSecret,
      this.paymentMethod,
      required this.customerId});

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      amount: json['amount'] as int,
      currency: json['currency'] as String,
      clientSecret: json['client_secret'],
      paymentMethod: json['payment_method'],
      customerId: json['customer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount * 100,
      'currency': currency,
      'customer': customerId,
    };
  }
}
