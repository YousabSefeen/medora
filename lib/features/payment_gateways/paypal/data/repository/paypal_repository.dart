import 'package:dartz/dartz.dart';
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_services.dart' show PaypalServices, PaypalPaymentIntentResponse, PaypalTransactionModel;
import 'package:medora/features/payment_gateways/paypal/data/repository/paypal_base_repository.dart' show PaypalBaseRepository;

import '../../../../../core/error/failure.dart' ;


class PaypalRepository extends PaypalBaseRepository {
  final PaypalServices paypalServices;

  PaypalRepository({required this.paypalServices});

  @override
  Future<Either<Failure, PaypalPaymentIntentResponse>> createPaymentIntent({
    required PaypalTransactionModel paypalTransactionModel,
  }) async {
    try {
      final paymentIntentResponse = await paypalServices.createPaymentIntent(
          paypalTransaction: paypalTransactionModel);
      return right(paymentIntentResponse);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> executePaypalPayment(
      {required String executeUrl,
      required String payerId,
      required String accessToken}) async {
    try {
      final response = await paypalServices.executePaypalPayment(
        executeUrl: executeUrl,
        payerId: payerId,
        accessToken: accessToken,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
