


import 'package:webview_flutter/webview_flutter.dart'  ;

abstract class WebViewNavigator {
  void setNavigationDelegate(NavigationDelegate delegate);

  void loadRequest(Uri uri);

  void setJavaScriptMode(JavaScriptMode mode);
}