import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:medora/core/error/paymob_error_handler.dart'
    show PaymobErrorHandler;
import 'package:medora/core/payment_gateway_manager/paymob_payment/paymob_keys.dart'
    show PaymobKeys;
import 'package:medora/features/payment_gateways/paymob/data/repository/paymob_repository.dart'
    show PaymobRepository;
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataResultModel;
import 'package:medora/features/payment_gateways/shared/web_view_navigator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../states/paymob_payment_state.dart';

class PaymobPaymentCubit extends Cubit<PaymobPaymentState> {
  final PaymobRepository paymobRepository;

  PaymobPaymentCubit({required this.paymobRepository})
    : super(const PaymobPaymentState());

  PaymentGatewaysTypes? _paymentGatewaysTypes;

  Future<void> createPaymentIntent({
    required PaymentGatewaysTypes selectedPaymentMethod,
    required String phoneNumber,
    required int totalPrice,
  }) async {
    _paymentGatewaysTypes = selectedPaymentMethod;
    if (_paymentGatewaysTypes == PaymentGatewaysTypes.paymobMobileWallets) {
      await _processMobileWalletPayment(
        phoneNumber: phoneNumber,
        totalPrice: totalPrice,
      );
    } else {
      await _processVisaPayment(totalPrice: totalPrice);
    }
  }

  Future<void> _processMobileWalletPayment({
    required String phoneNumber,
    required int totalPrice,
  }) async {
    emit(state.copyWith(paymentIntentState: LazyRequestState.loading));
    final response = await paymobRepository.processMobileWalletPayment(
      selectedPaymentMethod: _paymentGatewaysTypes!,
      phoneNumber: phoneNumber,
      totalPrice: totalPrice,
    );
    response.fold(
      (failure) {
        print('failure: ${failure.toString()}');
        emit(
          state.copyWith(
            paymentIntentState: LazyRequestState.error,
            paymentIntentErrorMsg: failure.toString(),
          ),
        );
      },
      (redirectUrl) {
        emit(
          state.copyWith(
            paymentIntentState: LazyRequestState.loaded,
            paymobMobileWalletsRedirectUrl: redirectUrl,
          ),
        );

        print('Mobile Wallets redirectUrl: $redirectUrl');
      },
    );
  }

  Future<void> _processVisaPayment({required int totalPrice}) async {
    emit(state.copyWith(paymentIntentState: LazyRequestState.loading));
    final response = await paymobRepository.processVisaPayment(
      selectedPaymentMethod: _paymentGatewaysTypes!,
      totalPrice: totalPrice,
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            paymentIntentState: LazyRequestState.error,
            paymentIntentErrorMsg: failure.toString(),
          ),
        );
        print('failure: ${failure.toString()}');
      },
      (iframeUrl) {
        print('processVisaPayment.Successs $iframeUrl');
        emit(
          state.copyWith(
            paymentIntentState: LazyRequestState.loaded,
            paymobCardIframeUrl: iframeUrl,
          ),
        );
      },
    );
  }

  Future<void> setupWebView(WebViewNavigator? webViewNavigator) async {
    emit(state.copyWith(webViewStatus: WebViewStatus.init));
    if (webViewNavigator == null) {
      _emitWebViewError('WebView navigator not initialized.');
      return;
    }

    webViewNavigator
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (state.progressValue == 100) {
              return;
            } else {
              emit(state.copyWith(progressValue: progress));
            }
          },
          onPageFinished: _handlePageFinished,
        ),
      )
      ..loadRequest(Uri.parse(_buildIframeUrl()));
  }

  String _buildIframeUrl() {
    final isWallet =
        _paymentGatewaysTypes == PaymentGatewaysTypes.paymobMobileWallets;
    return isWallet
        ? state.paymobMobileWalletsRedirectUrl
        : PaymobKeys.onlineCardIframeUrl(state.paymobCardIframeUrl);
  }

  Future<void> _handlePageFinished(String url) async {
    print('PaymobPaymentCubit._handlePageFinished: $url');
    emit(state.copyWith(webViewStatus: WebViewStatus.finished));
    if (url.contains(PaymobKeys.ngrokUrl)) {
      final result = _PaymobResultParser.parse(url);
      if (result.success == 'true') {
        emit(
          state.copyWith(
            webViewStatus: WebViewStatus.success,
            transactionResult: result,
          ),
        );
      } else {
        emit(
          state.copyWith(
            webViewStatus: WebViewStatus.error,
            transactionResult: result,
            webViewErrorMessage: PaymobErrorHandler.getErrorMessage(
              result.dataMessage,
            ),
          ),
        );
      }
    }
  }

  void _emitWebViewError(String errorMessage) => emit(
    state.copyWith(
      webViewStatus: WebViewStatus.error,
      webViewErrorMessage: errorMessage,
    ),
  );

  void resetStates() => emit(
    state.copyWith(
      paymentIntentState: LazyRequestState.lazy,
      webViewStatus: WebViewStatus.init,
      paymentIntentErrorMsg: '',
      webViewErrorMessage: '',
    ),
  );
}

class _PaymobResultParser {
  static PaymobTransactionDataResultModel parse(String url) {
    final uri = Uri.parse(url);
    final result = PaymobTransactionDataResultModel.fromJson(uri.queryParameters);
    return result;
  }
}
