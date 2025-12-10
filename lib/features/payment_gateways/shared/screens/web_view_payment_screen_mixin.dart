import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:medora/core/payment_gateway_manager/payment_helper/payment_navigation_helper.dart'
    show PaymentNavigationHelper;
import 'package:medora/features/payment_gateways/shared/widgets/web_view_payment_body.dart'
    show WebViewPaymentBody;
import 'package:webview_flutter/webview_flutter.dart';

mixin WebViewPaymentScreenMixin<T extends StatefulWidget> on State<T> {
  late final WebViewController webViewController;
  late final dynamic paymentCubit;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController();
    initializePayment();
  }

  @override
  void dispose() {
    webViewController.clearCache();
    super.dispose();
  }

  void initializePayment();

  Future<void> setupWebView();

  void handlePaymentSuccess(dynamic successData);

  String get screenTitle;

  void resetPaymentStates();

  bool shouldShowError(dynamic state) =>
      state.paymentIntentState == LazyRequestState.error ||
      state.webViewStatus == WebViewStatus.error;

  bool shouldSetupWebView(dynamic state) =>
      state.paymentIntentState == LazyRequestState.loaded &&
      state.webViewStatus == WebViewStatus.init &&
      state.progressValue == 0;

  void handleErrorState() {
    if (mounted) {
      Navigator.pop(context, AppStrings.paymentFailedError);
    }
  }

  void _popWithPaymentCancelledResult() =>
      PaymentNavigationHelper.popWithPaymentCancelledResult(context);

  Widget buildPaymentScreen(BuildContext context, dynamic state) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          !didPop ? _popWithPaymentCancelledResult() : null,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => _popWithPaymentCancelledResult(),
          ),
          title: Text(screenTitle),
        ),
        body: WebViewPaymentBody(
          paymentProcessingState: state.paymentIntentState,
          webViewStatus: state.webViewStatus,
          webViewController: webViewController,
          loadingProgress: state.progressValue,
        ),
      ),
    );
  }
}
