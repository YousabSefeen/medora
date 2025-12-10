import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataModel;

class PaymobPaymentState extends Equatable {
  final LazyRequestState paymentIntentState;
  final String paymentIntentErrorMsg;
  final WebViewStatus webViewStatus;
  final int progressValue;
  final PaymobTransactionDataModel? transactionResult;
  final String webViewErrorMessage;
  final String paymobMobileWalletsRedirectUrl;
  final String paymobCardIframeUrl;

  const PaymobPaymentState({
    this.paymentIntentState = LazyRequestState.lazy,
    this.paymentIntentErrorMsg = '',
    this.webViewStatus = WebViewStatus.init,
    this.progressValue = 0,
    this.transactionResult,
    this.webViewErrorMessage = '',
    this.paymobMobileWalletsRedirectUrl = '',
    this.paymobCardIframeUrl = '',
  });

  PaymobPaymentState copyWith({
    LazyRequestState? paymentIntentState,
    String? paymentIntentErrorMsg,
    WebViewStatus? webViewStatus,
    int? progressValue,
    PaymobTransactionDataModel? transactionResult,
    String? webViewErrorMessage,
    String? paymobMobileWalletsRedirectUrl,
    String? paymobCardIframeUrl,
  }) {
    return PaymobPaymentState(
      paymentIntentState: paymentIntentState ?? this.paymentIntentState,
      paymentIntentErrorMsg:
          paymentIntentErrorMsg ?? this.paymentIntentErrorMsg,
      webViewStatus: webViewStatus ?? this.webViewStatus,
      progressValue: progressValue ?? this.progressValue,
      transactionResult: transactionResult ?? this.transactionResult,
      webViewErrorMessage: webViewErrorMessage ?? this.webViewErrorMessage,
      paymobMobileWalletsRedirectUrl:
          paymobMobileWalletsRedirectUrl ?? this.paymobMobileWalletsRedirectUrl,
      paymobCardIframeUrl: paymobCardIframeUrl ?? this.paymobCardIframeUrl,
    );
  }

  @override
  List<Object?> get props => [
    paymentIntentState,
    paymentIntentErrorMsg,
    webViewStatus,
    progressValue,
    transactionResult,
    webViewErrorMessage,
    paymobMobileWalletsRedirectUrl,
    paymobCardIframeUrl,
  ];
}
