import 'package:dartz/dartz.dart';
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/core/payment_gateway_manager/paymob_payment/paymob_services.dart'
    show PaymobServices;

import '../../../../../Core/Error/failure.dart';
import 'base_paymob_repository.dart';

class PaymobRepository extends BasePaymobRepository {
  final PaymobServices paymobServices;

  PaymobRepository({required this.paymobServices});

  @override
  Future<Either<Failure, String>> processMobileWalletPayment({
    required PaymentGatewaysTypes selectedPaymentMethod,
    required String phoneNumber,
    required int totalPrice,
  }) async {
    try {
      final redirectUrl = await paymobServices.processMobileWalletPayment(
        selectedPaymentMethod: selectedPaymentMethod,
        totalPrice: totalPrice,
        phoneNumber: phoneNumber,
      );

      return right(redirectUrl);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, String>> processVisaPayment({
    required PaymentGatewaysTypes selectedPaymentMethod,
    required int totalPrice,
  }) async {
    try {
      final iframeUrl = await paymobServices.processVisaPayment(
        selectedPaymentMethod: selectedPaymentMethod,
        totalPrice: totalPrice,
      );
      return right(iframeUrl);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
