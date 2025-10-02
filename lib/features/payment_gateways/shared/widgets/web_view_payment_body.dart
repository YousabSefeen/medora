import 'package:flutter/material.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;

import 'package:webview_flutter/webview_flutter.dart'
    show WebViewController, WebViewWidget;

class WebViewPaymentBody extends StatelessWidget {
  final LazyRequestState paymentProcessingState;
  final WebViewStatus webViewStatus;
  final int loadingProgress;
  final WebViewController webViewController;

  const WebViewPaymentBody({
    super.key,
    required this.paymentProcessingState,
    required this.webViewStatus,
    required this.webViewController,
    required this.loadingProgress,
  });

  @override
  Widget build(BuildContext context) {
    return _buildPaymentGatewayView();
  }

  Widget _buildPaymentGatewayView() {
    if (paymentProcessingState == LazyRequestState.loading) {
      return _buildInitialLoadingIndicator();
    } else if (paymentProcessingState == LazyRequestState.error ||
        webViewStatus == WebViewStatus.error) {
      return _buildErrorState();
    } else {
      return webViewStatus == WebViewStatus.finished
          ? _buildPaymentWebView()
          : _buildLoadingProgressIndicator(loadingProgress);
    }
  }

  Widget _buildInitialLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget _buildErrorState() => const SizedBox();

  Widget _buildPaymentWebView() => WebViewWidget(controller: webViewController);

  Widget _buildLoadingProgressIndicator(int progress) {
    return LinearProgressIndicator(
      value: progress / 100,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
      backgroundColor: Colors.blueAccent,
    );
  }
}
