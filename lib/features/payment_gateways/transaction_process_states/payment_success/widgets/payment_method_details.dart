import 'package:flutter/material.dart';
import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/presentation/view/payment_success/widgets/paymob_payment_method_info.dart' show PaymobPaymentMethodInfo;
import 'package:medora/features/payment_gateways/paypal/transaction_process_states/presentation/widgets/paypal_payment_method_info.dart' show PaypalPaymentMethodInfo;
import 'package:medora/features/payment_gateways/stripe/transaction_process_states/view/payment_success/presentation/widgets/stripe_payment_method_info.dart' show StripePaymentMethodInfo;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart' show PaymentSuccessScreen;

class PaymentMethodDetails extends StatelessWidget {
  final PaymentGatewaysTypes paymentMethod;


  const PaymentMethodDetails({
    super.key,
    required this.paymentMethod,

  });

  @override
  Widget build(BuildContext context) {
    switch (paymentMethod) {
      case PaymentGatewaysTypes.none:
      case PaymentGatewaysTypes.paymobMobileWallets:
      case PaymentGatewaysTypes.paymobCard:
        return PaymobPaymentMethodInfo(transactionData:(context.findAncestorWidgetOfExactType<PaymentSuccessScreen>() as PaymentSuccessScreen).paymobResponseModel!);
      case PaymentGatewaysTypes.stripe:
        return const StripePaymentMethodInfo();
      case PaymentGatewaysTypes.payPal:
        return PaypalPaymentMethodInfo(
            userEmail:(context.findAncestorWidgetOfExactType<PaymentSuccessScreen>() as PaymentSuccessScreen).paypalPayerEmail!
        );
      }
  }
}
