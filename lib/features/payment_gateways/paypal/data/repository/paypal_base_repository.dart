


import 'package:dartz/dartz.dart';
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_services.dart' show PaypalPaymentIntentResponse, PaypalTransactionModel;


import '../../../../../core/error/failure.dart'  ;





abstract class PaypalBaseRepository{

  Future<Either<Failure, PaypalPaymentIntentResponse>> createPaymentIntent({
    required PaypalTransactionModel paypalTransactionModel,

  });

  Future<Either<Failure, Map<String,dynamic>>> executePaypalPayment({
    required String executeUrl,
    required String payerId,
    required String accessToken,
  });

}