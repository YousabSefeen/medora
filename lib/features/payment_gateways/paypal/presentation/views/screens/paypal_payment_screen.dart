import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/payment_gateways/paypal/presentation/controller/cubit/paypal_payment_cubit.dart' show PaypalPaymentCubit;
import 'package:medora/features/payment_gateways/paypal/presentation/controller/states/paypal_payment_states.dart' show PaypalPaymentState;
import 'package:medora/features/payment_gateways/shared/actual_web_view_controller_navigator.dart' show ActualWebViewControllerNavigator;
import 'package:medora/features/payment_gateways/shared/screens/web_view_payment_screen_mixin.dart' show WebViewPaymentScreenMixin;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart' show PaymentSuccessScreen;

class PaypalPaymentScreen extends StatefulWidget {
  const PaypalPaymentScreen({super.key});

  @override
  State<PaypalPaymentScreen> createState() => _PaypalPaymentScreenState();
}

class _PaypalPaymentScreenState extends State<PaypalPaymentScreen>
    with WebViewPaymentScreenMixin {
  late final PaypalPaymentCubit _paymentCubit;

  @override
  void initializePayment() {
    _paymentCubit = serviceLocator<PaypalPaymentCubit>()..createPaymentIntent();
  }

  @override
  Future<void> setupWebView() async {
    await _paymentCubit.setupWebView(
      ActualWebViewControllerNavigator(webViewController),
    );
  }

  @override
  String get screenTitle => 'Paypal Payment';

  @override
  void handlePaymentSuccess(dynamic successData) {
    if (mounted) {
      AppRouter.pushAndRemoveUntil(
        context,
        PaymentSuccessScreen(
          paymentMethod: PaymentGatewaysTypes.payPal,
          paypalPayerEmail: successData,
        ),
      );
    }
  }

  @override
  void resetPaymentStates() => _paymentCubit.resetStates();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _paymentCubit,
      child: BlocConsumer<PaypalPaymentCubit, PaypalPaymentState>(
        listener: (context, state) {
          if (shouldShowError(state)) {
            handleErrorState();
          } else if (shouldSetupWebView(state)) {
            setupWebView();
          } else if (state.webViewStatus == WebViewStatus.success) {
            resetPaymentStates();
            handlePaymentSuccess(state.payerEmail);
          }
        },
        builder: (context, state) => buildPaymentScreen(context, state),
      ),
    );
  }
}



