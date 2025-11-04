import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_keys.dart' show PaypalKeys;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_services.dart' show PaypalTransactionModel;
import 'package:medora/features/payment_gateways/paypal/data/repository/paypal_repository.dart' show PaypalRepository;
import 'package:medora/features/payment_gateways/paypal/presentation/controller/states/paypal_payment_states.dart' show PaypalPaymentState;
import 'package:medora/features/payment_gateways/shared/web_view_navigator.dart' show WebViewNavigator;

import 'package:webview_flutter/webview_flutter.dart';

class PaypalPaymentCubit extends Cubit<PaypalPaymentState> {
  final PaypalRepository paypalRepository;


  PaypalPaymentCubit({
    required this.paypalRepository,

  }) : super(const PaypalPaymentState());

  Future<void> createPaymentIntent() async {

    emit(state.copyWith(paymentIntentState: LazyRequestState.loading));
    final paypalTransactionModel = PaypalTransactionModel(
      intent: 'sale',
      transactions: [
        {
          'amount': {
            'currency': 'USD', // يمكنك جعلها ديناميكية إذا لزم الأمر
            'total': 100.toStringAsFixed(2),
          },
          'description': 'Appointment Booking',
          'item_list': {
            'items': [
              {
                'name': 'Appointment Booking',
                'quantity': '1',
                'price': 100.toStringAsFixed(2),
                'currency': 'USD',
              }
            ]
          }
        }
      ],
      returnUrl: PaypalKeys.successUrl,
      cancelUrl: PaypalKeys.cancelUrl,
    );

    final responseEither = await paypalRepository.createPaymentIntent(
      paypalTransactionModel: paypalTransactionModel,
    );

    responseEither.fold(
      (failure) {
        emit(state.copyWith(
          paymentIntentState: LazyRequestState.error,
          paymentIntentErrorMsg: failure.toString(),
        ));
      },
      (paypalPaymentIntentResponse) {
        emit(state.copyWith(
          paymentIntentResponse: paypalPaymentIntentResponse,
          paymentIntentState: LazyRequestState.loaded,

        ));

        printData();
      },
    );
  }

  printData() {
    print('webViewStatus  ${state.webViewStatus.name}');

    print(
        'approvalUrl  ${state.paymentIntentResponse?.paypalPaymentLinks.approvalUrl}');
    print(
        'executeUrl  ${state.paymentIntentResponse?.paypalPaymentLinks.executeUrl}');
    print('accessToken ${state.paymentIntentResponse?.accessToken}');
  }

  Future<void> setupWebView(WebViewNavigator? webViewNavigator) async {
    emit(state.copyWith(webViewStatus: WebViewStatus.init));
    if (webViewNavigator == null) {
      _emitWebViewError('WebView navigator not initialized.');
      return;
    }

    webViewNavigator
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          if(state.progressValue==100){
            return;
          }else{
            emit(state.copyWith(progressValue: progress ));
          }


        },
        onPageFinished: _handlePageFinished,

      ))
      ..loadRequest(Uri.parse(
          state.paymentIntentResponse!.paypalPaymentLinks.approvalUrl));
  }



  Future<void> _handlePageFinished(String url) async {
    print('PaypalWebViewCubit._handlePageFinished: $url');
    emit(state.copyWith(webViewStatus: WebViewStatus.finished));
    if (url.startsWith(PaypalKeys.successUrl)) {
      await _processSuccessPayment(url);
    } else if (url.startsWith(PaypalKeys.cancelUrl)) {
      _processCancelledPayment();
    }
  }

  Future<void> _processSuccessPayment(String url) async {
    final uri = Uri.parse(url);
    final paymentId = uri.queryParameters['paymentId'];
    final payerId = uri.queryParameters['PayerID'];

    if (paymentId == null || payerId == null) {
      final errorMessage = 'PayPal success URL missing paymentId or PayerID.';
      _emitWebViewError(errorMessage);

      return;
    }

    await _executePaypalPayment(payerId: payerId);
  }


  void _processCancelledPayment() =>
      _emitWebViewError(AppStrings.paymentCancelledError);

  Future<void> _executePaypalPayment({required String payerId}) async {
    final responseEither = await paypalRepository.executePaypalPayment(
      payerId: payerId,
      executeUrl: state.paymentIntentResponse!.paypalPaymentLinks.executeUrl,
      accessToken: state.paymentIntentResponse!.accessToken,
    );
    responseEither.fold((failure) => _emitWebViewError(failure.toString()),
        (result) {
      if (result['success']) {
        emit(state.copyWith(
          webViewStatus: WebViewStatus.success,
          payerEmail: result['payerEmail'] as String?,
        ));
      } else {
        _emitWebViewError(
            result['message'] ?? 'Payment not approved by PayPal.',
        );
      }
    });
  }
  void resetStates()=> emit(state.copyWith(
    paymentIntentState: LazyRequestState.lazy,
    webViewStatus: WebViewStatus.init,
    paymentIntentErrorMsg: '',
    webViewErrorMessage: '',
  ));
  void _emitWebViewError(String errorMessage) => emit(state.copyWith(
        webViewStatus: WebViewStatus.error,
        webViewErrorMessage: errorMessage,
      ));
}




/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:flutter_task/core/enum/web_view_status.dart' show WebViewStatus;
import 'package:flutter_task/core/payment_gateway_manager/paypal_payment/paypal_keys.dart' show PaypalKeys;
import 'package:flutter_task/core/payment_gateway_manager/paypal_payment/paypal_services.dart';
import 'package:flutter_task/features/payment_gateways/paypal/data/favorites_repository_base/paypal_repository.dart' show PaypalRepository;
import 'package:flutter_task/features/payment_gateways/paypal/presentation/controller/states/paypal_payment_states.dart' show PaypalPaymentState;

import 'package:webview_flutter/webview_flutter.dart';

class PaypalPaymentCubit extends Cubit<PaypalPaymentState> {
  final PaypalRepository paypalRepository;
  final PaypalServices paypalServices;

  PaypalPaymentCubit({
    required this.paypalRepository,
    required this.paypalServices,
  }) : super(const PaypalPaymentState());





  Future<void>  createPaymentIntent( ) async {
    final paypalTransactionModel = PaypalTransactionModel(
      intent: 'sale',
      transactions: [
        {
          'amount': {
            'currency': 'USD', // يمكنك جعلها ديناميكية إذا لزم الأمر
            'total': 100.toStringAsFixed(2),
          },
          'description': 'Appointment Booking',
          'item_list': {
            'items': [
              {
                'name': 'Appointment Booking',
                'quantity': '1',
                'price': 100.toStringAsFixed(2),
                'currency': 'USD',
              }
            ]
          }
        }
      ],
      returnUrl: PaypalKeys.successUrl,
      cancelUrl: PaypalKeys.cancelUrl,
    );

    final responseEither = await paypalRepository.createPaymentIntent(
      paypalTransactionModel: paypalTransactionModel,
    );

    responseEither.fold(
          (failure) {
        emit(state.copyWith(
          paymentIntentState: LazyRequestState.error,
          paymentIntentErrorMsg: failure.toString(),
        ));
      },
          (paypalPaymentIntentResponse) {


        emit(state.copyWith(

            paymentIntentResponse: paypalPaymentIntentResponse,
          paymentIntentState: LazyRequestState.loaded,
          webViewStatus: WebViewStatus.init,

        ));


        printData();

      },
    );
  }

  printData() {
    print('webViewStatus  ${state.webViewStatus.name}');

    print(
        'approvalUrl  ${state.paymentIntentResponse?.paypalPaymentLinks.approvalUrl}');
    print(
        'executeUrl  ${state.paymentIntentResponse?.paypalPaymentLinks.executeUrl}');
    print('accessToken ${state.paymentIntentResponse?.accessToken}');
  }



  Future<void>  setupWebView( WebViewNavigator?  webViewNavigator) async{
    emit(state.copyWith(
    webViewStatus: WebViewStatus.init,
    ));
    if ( webViewNavigator == null) {
      emit(state.copyWith(
          webViewStatus: WebViewStatus.error,
        webViewErrorMessage: 'WebView navigator not initialized.',
      )
      );
      return;
    }

    webViewNavigator
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(

            onProgress: (progress) {},


        onPageFinished: _handlePageFinished,
        onWebResourceError: _handleWebResourceError,
      ))
      ..loadRequest(Uri.parse(
          state.paymentIntentResponse!.paypalPaymentLinks.approvalUrl));
  }

  void _handleWebResourceError(WebResourceError error) {




  }

  Future<void> _handlePageFinished(String url) async {
    print('PaypalWebViewCubit._handlePageFinished: $url');
    emit(state.copyWith(webViewStatus: WebViewStatus.finished));
    if (url.startsWith(PaypalKeys.successUrl)) {
      await _processSuccessPayment(url);
    } else if (url.startsWith(PaypalKeys.cancelUrl)) {
      _processCancelledPayment();
    }
  }

  Future<void> _processSuccessPayment(String url) async {
    final uri = Uri.parse(url);
    final paymentId = uri.queryParameters['paymentId'];
    final payerId = uri.queryParameters['PayerID'];

    if (paymentId == null || payerId == null) {
      // 9. معالجة حالات عدم وجود المعرفات
      final errorMessage = 'PayPal success URL missing paymentId or PayerID.';
      emit(state.copyWith(
        webViewStatus: WebViewStatus.error,
        webViewErrorMessage: errorMessage,
      ));

      return;
    }

    try {
      final Map<String, dynamic> result =
      await paypalServices.executePaypalPayment(
        payerId: payerId,
        executeUrl:
        state.paymentIntentResponse!.paypalPaymentLinks.executeUrl,
        accessToken: state.paymentIntentResponse!.accessToken,
      );
      if (result['success']) {
        final payerEmail =
        result['data']?['payer']?['payer_info']?['email']?.toString();
        emit(state.copyWith(
          webViewStatus: WebViewStatus.success,
          payerEmail: payerEmail, // تمرير الإيميل المستخرج
        ));
      } else {
        emit(state.copyWith(
          webViewStatus: WebViewStatus.error,
          webViewErrorMessage:
          result['message'] ?? 'Payment not approved by PayPal.',
        ));
      }
    } catch (e) {
      // 11. تسجيل الأخطاء بشكل أفضل
      print('Error executing PayPal payment: $e');
      emit(state.copyWith(
        webViewStatus: WebViewStatus.error,
        webViewErrorMessage: e.toString(), // يمكن تحسين رسالة الخطأ هنا
      ));
    } finally {
      // 12. التأكد من استدعاء الكولباك دائمًا بعد اكتمال العملية
    }
  }

  // 13. فصل منطق معالجة الإلغاء إلى دالة منفصلة (SRP)
  void _processCancelledPayment() {
    emit(state.copyWith(
      webViewStatus: WebViewStatus.error,
      webViewErrorMessage: 'Payment cancelled by user.',
    ));
  }
}

class ActualWebViewControllerNavigator implements WebViewNavigator {
  final WebViewController _controller;

  ActualWebViewControllerNavigator(this._controller);

  @override
  void setNavigationDelegate(NavigationDelegate delegate) => _controller.setNavigationDelegate(delegate);

  @override
  void loadRequest(Uri uri) => _controller.loadRequest(uri);

  @override
  void setJavaScriptMode(JavaScriptMode mode) => _controller.setJavaScriptMode(mode);
}

abstract class WebViewNavigator {
  void setNavigationDelegate(NavigationDelegate delegate);

  void loadRequest(Uri uri);

  void setJavaScriptMode(JavaScriptMode mode);
}
 */