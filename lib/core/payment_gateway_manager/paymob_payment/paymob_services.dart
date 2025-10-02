import 'package:dio/dio.dart';
import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
import 'package:medora/core/payment_gateway_manager/paymob_payment/paymob_dummy_data_service.dart' show PaymobDummyDataService;
import 'package:medora/core/payment_gateway_manager/paymob_payment/paymob_keys.dart' show PaymobKeys;
import 'package:medora/core/services/api_services.dart' show ApiServices;

class PaymobServices {
  final ApiServices apiServices;

  PaymobServices({required this.apiServices});

  final Options _defaultOptions =
      Options(headers: {'Content-Type': 'application/json'});

  // *Required First method
  Future<String> _fetchAuthToken() async {
    final Response response = await apiServices.post(
      url: PaymobKeys.fetchAuthTokenUrl,
      options: _defaultOptions,
      data: {'api_key': PaymobKeys.apiKey},
    );

    final token = response.data?['token']?.toString();
    if (token == null) {
      throw Exception('Invalid response:Missing Fetch Auth Token');
    }
    return token;
  }

  Future<String> _fetchOrderId(
      {required String token, required int totalPrice}) async {
    final Response response = await apiServices.post(
      url: PaymobKeys.orderCreationUrl,
      options: _defaultOptions,
      data: {
        'auth_token': token,
        'currency': 'EGP',
        'integrations': [PaymobKeys.integrationOnlineCardId],
        'amount_cents': totalPrice*100,
      },
    );

    final orderId = response.data?['id']?.toString();

    if (orderId == null) {
      throw Exception('Invalid response:Missing order ID');
    }

    return orderId;
  }

  Future _fetchPaymentRequest(
      {
        required PaymentGatewaysTypes selectedPaymentMethod,
    required String authToken,
    required int totalPrice,
    required String orderId,
  }) async {
    final requestData = {
      'auth_token': authToken,
      'amount_cents': totalPrice,
      'billing_data': PaymobDummyDataService.billingData.toJson(),
      'order_id': orderId,
      'integration_id':
          selectedPaymentMethod == PaymentGatewaysTypes.paymobMobileWallets
              ? PaymobKeys.integrationMobileWalletId.toString()
              : PaymobKeys.integrationOnlineCardId.toString(),
      'expiration': 3600,

      'currency': 'EGP',

      'lock_order_when_paid': 'false',
    };

    final response = await apiServices.post(
      url: PaymobKeys.fetchPaymentRequestUrl,
      options: _defaultOptions,
      data: requestData,
    );

    final finalToken = response.data?['token'];

    if (finalToken == null) {
      throw Exception('Invalid response:Missing fetch Payment Request');
    }

    return finalToken;
  }

  Future _processMobileWalletPayment(
      {required String phoneNumber, required String paymentToken}) async {
    final paymentData = {
      'source': {
        'identifier': phoneNumber,
        'subtype': 'WALLET',
      },
      'payment_token': paymentToken,
    };

    final response = await apiServices.post(
      url: PaymobKeys.walletPaymentUrl,
      options: _defaultOptions,
      data: paymentData,
    );

    final redirectUrl = response.data?['redirect_url']?.toString();

    if (redirectUrl == null) {
      throw Exception(
          'Invalid response:Missing  Redirect URL in mobile wallets');
    }

    return redirectUrl;
  }

  Future<String> _fitchPaymentToken(
      {required PaymentGatewaysTypes selectedPaymentMethod,
      required int totalPrice}) async {
    // تحويل المبلغ من ال (المبلغ بالسنتات) الي الجنية المصري بالضرب في 100
    final _totalPrice = totalPrice * 100;
    final String token = await _fetchAuthToken();

    final orderId = await _fetchOrderId(token: token, totalPrice: _totalPrice);

    final paymentToken = await _fetchPaymentRequest(
      selectedPaymentMethod: selectedPaymentMethod,
      authToken: token,
      orderId: orderId,
      totalPrice: _totalPrice,
    );

    return paymentToken;
  }

  Future<String> processVisaPayment({
    required PaymentGatewaysTypes selectedPaymentMethod,
    required int totalPrice,
  }) async {
    final paymentToken = await _fitchPaymentToken(
      selectedPaymentMethod: selectedPaymentMethod,
      totalPrice: totalPrice,
    );

    return paymentToken;
  }

  Future<String> processMobileWalletPayment(
      {required PaymentGatewaysTypes selectedPaymentMethod,
    required String phoneNumber,
    required int totalPrice,
  }) async {
    final paymentToken = await _fitchPaymentToken(
      selectedPaymentMethod: selectedPaymentMethod,
      totalPrice: totalPrice,
    );

    final redirectUrl = await _processMobileWalletPayment(
      phoneNumber: phoneNumber,
      paymentToken: paymentToken,
    );

    return redirectUrl;
  }
}
