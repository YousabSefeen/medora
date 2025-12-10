import 'package:medora/features/payment_gateways/shared/web_view_navigator.dart'
    show WebViewNavigator;
import 'package:webview_flutter/webview_flutter.dart';

class ActualWebViewControllerNavigator implements WebViewNavigator {
  final WebViewController _controller;

  ActualWebViewControllerNavigator(this._controller);

  @override
  void setNavigationDelegate(NavigationDelegate delegate) =>
      _controller.setNavigationDelegate(delegate);

  @override
  void loadRequest(Uri uri) => _controller.loadRequest(uri);

  @override
  void setJavaScriptMode(JavaScriptMode mode) =>
      _controller.setJavaScriptMode(mode);
}
