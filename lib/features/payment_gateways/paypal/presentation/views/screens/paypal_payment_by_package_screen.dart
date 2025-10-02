
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:medora/core/animations/custom_animation_route.dart' show CustomAnimationRoute;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_dummy_data_service.dart' show PaypalDummyDataService;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_keys.dart' show PaypalKeys;
import 'package:medora/features/payment_gateways/paypal/transaction_process_states/data/models/paypal_payment_response_model.dart' show PaypalPaymentResponseModel;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_failed/screens/payment_failed_screen.dart' show PaymentFailedScreen;

class PaypalPaymentByPackageScreen extends StatelessWidget {
  const PaypalPaymentByPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PaypalCheckoutView(
          sandboxMode: true,
          clientId: PaypalKeys.clientId,
          secretKey: PaypalKeys.secretKey,
          transactions: [
            PaypalDummyDataService.paypalPaymentTransactionModel,
          ],
          note: 'Contact us for any questions on your order.',
          onSuccess: (Map params) async {
            print('PaypalPaymentScreen.params  $params');
            final dataRes = PaypalPaymentResponseModel.fromJson(params);
            final payerEmail = dataRes.data?.payer.payerInfo.email;
            //ooooooooooooooooooooooooooo
            // AppRouter.pushAndRemoveUntil(
            //   context,
            //   PaymentSuccessScreen(
            //     paymentMethod: PaymentGatewaysTypes.payPal,
            //     paypalPayerEmail: payerEmail,
            //   ),
            // );
            
          },
          onError: (error) {
            print("onError: $error");
            
            Navigator.of(context).pushAndRemoveUntil(
                CustomAnimationRoute(
                  screen: PaymentFailedScreen(
                    paymentMethod: 'paypal',
                    errorMessage: error,
                  ),
                ),
                (_) => false);

          },
          onCancel: () async{

              print(
                  '*****************************cancelled*****************************:');

          //  AppRouter.pop(context,returnValue: AppStrings.paymentCancelledError);
            
            

          },
        ),
      ),
    );
  }
}
