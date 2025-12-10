import 'package:dartz/dartz.dart';
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;

import '../../../../../Core/Error/failure.dart';

abstract class BasePaymobRepository {
  Future<Either<Failure, String>> processVisaPayment({
    required PaymentGatewaysTypes selectedPaymentMethod,
    required int totalPrice,
  });

  Future<Either<Failure, String>> processMobileWalletPayment({
    required PaymentGatewaysTypes selectedPaymentMethod,
    required String phoneNumber,
    required int totalPrice,
  });
}
