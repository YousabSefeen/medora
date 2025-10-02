
import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_services.dart' show PaypalPaymentIntentResponse;


class PaypalPaymentState extends Equatable {

  final LazyRequestState  paymentIntentState;
  final String? paymentIntentErrorMsg;


  final WebViewStatus webViewStatus;
  final int progressValue;
  final String? webViewErrorMessage;
  final PaypalPaymentIntentResponse? paymentIntentResponse;
  final String? paypalPayerId; //  From WebView Callback
  final String? payerEmail; //  From executePayment Result

  const PaypalPaymentState({

    this.paymentIntentState = LazyRequestState.lazy,
    this.paymentIntentErrorMsg='',
    this.webViewStatus = WebViewStatus.init,
    this.progressValue=0,
    this.webViewErrorMessage,
    this.paymentIntentResponse,
    this.paypalPayerId,
    this.payerEmail,
  });

  PaypalPaymentState copyWith({

    LazyRequestState? paymentIntentState,
    String? paymentIntentErrorMsg,
    WebViewStatus? webViewStatus,
      int? progressValue,
    String? webViewErrorMessage,
    PaypalPaymentIntentResponse? paymentIntentResponse,
    String? paypalPayerId,
    String? payerEmail,
  }) {
    return PaypalPaymentState(

      paymentIntentState: paymentIntentState ?? this.paymentIntentState,
      paymentIntentErrorMsg: paymentIntentErrorMsg?? this.paymentIntentErrorMsg,
      webViewStatus: webViewStatus ?? this.webViewStatus,
      progressValue: progressValue ?? this.progressValue,
      webViewErrorMessage: webViewErrorMessage ?? this.webViewErrorMessage,
      paymentIntentResponse:
          paymentIntentResponse ?? this.paymentIntentResponse,
      paypalPayerId: paypalPayerId ?? this.paypalPayerId,
      payerEmail: payerEmail ?? this.payerEmail,
    );
  }

  @override
  List<Object?> get props => [

    paymentIntentState,
    paymentIntentErrorMsg,
    webViewStatus,
    progressValue,
        webViewErrorMessage,
        paymentIntentResponse,
        paypalPayerId,
        payerEmail,
  ];
}