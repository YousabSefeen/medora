import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;

class WebViewActionState {
  final WebViewStatus webViewStatus;
  final String? webViewErrorMessage;
  final dynamic dataResponse;

  WebViewActionState({
    required this.webViewStatus,
    required this.webViewErrorMessage,
    required this.dataResponse,
  });
}

class PaymentActionState {
  double progress;
  final WebViewStatus webViewStatus;
  final String? webViewErrorMessage;
  final dynamic dataResponse;

  PaymentActionState({
    required this.progress,
    required this.webViewStatus,
    required this.webViewErrorMessage,
    required this.dataResponse,
  });
}
