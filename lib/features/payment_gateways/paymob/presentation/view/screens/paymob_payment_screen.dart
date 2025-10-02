import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;

import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/payment_gateways/paymob/presentation/controller/cubit/paymob_payment_cubit.dart' show PaymobPaymentCubit;
import 'package:medora/features/payment_gateways/paymob/presentation/controller/states/paymob_payment_state.dart' show PaymobPaymentState;
import 'package:medora/features/payment_gateways/shared/actual_web_view_controller_navigator.dart';
import 'package:medora/features/payment_gateways/shared/screens/web_view_payment_screen_mixin.dart' show WebViewPaymentScreenMixin;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart' show PaymentSuccessScreen;

class PaymobPaymentScreen extends StatefulWidget {
  final PaymentGatewaysTypes selectedPaymentMethod;
  final String phoneNumber;
  static const int defaultTotalPrice = 100;

  const PaymobPaymentScreen({
    super.key,
    required this.selectedPaymentMethod,
    required this.phoneNumber,
  });

  @override
  State<PaymobPaymentScreen> createState() => _PaymobPaymentScreenState();
}

class _PaymobPaymentScreenState extends State<PaymobPaymentScreen>
    with WebViewPaymentScreenMixin {
  late final PaymobPaymentCubit _paymentCubit;

  @override
  void initializePayment() {
    _paymentCubit = serviceLocator<PaymobPaymentCubit>()
      ..createPaymentIntent(
        selectedPaymentMethod: widget.selectedPaymentMethod,
        totalPrice: PaymobPaymentScreen.defaultTotalPrice,
        phoneNumber: widget.phoneNumber,
      );
  }

  @override
  Future<void> setupWebView() async {
    await _paymentCubit.setupWebView(
      ActualWebViewControllerNavigator(webViewController),
    );
  }

  @override
  String get screenTitle => widget.selectedPaymentMethod ==PaymentGatewaysTypes.paymobMobileWallets? AppStrings.mobileWallets: AppStrings.onlineCard;

  @override
  void handlePaymentSuccess(dynamic successData) {
    if (mounted) {
      AppRouter.pushAndRemoveUntil(
        context,
        PaymentSuccessScreen(
          paymentMethod: widget.selectedPaymentMethod,
          paymobResponseModel: successData,
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
      child: BlocConsumer<PaymobPaymentCubit, PaymobPaymentState>(
        listener: (context, state) {
          if (shouldShowError(state)) {
            handleErrorState();
          } else if (shouldSetupWebView(state)) {
            setupWebView();
          } else if (state.webViewStatus == WebViewStatus.success) {
            resetPaymentStates();
            handlePaymentSuccess(state.transactionResult);
          }
        },
        builder: (context, state) => buildPaymentScreen(context, state),
      ),
    );
  }
}