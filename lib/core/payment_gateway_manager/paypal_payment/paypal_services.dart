import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_keys.dart' show PaypalKeys;
import 'package:medora/core/services/api_services.dart' show ApiServices;


class PaypalTransactionModel {
  final String intent;
  final List<dynamic> transactions;

  // تم التغيير: الآن توقع روابط العودة والإلغاء بشكل منفصل
  final String returnUrl;
  final String cancelUrl;

  PaypalTransactionModel({
    required this.intent,
    required this.transactions,
    required this.returnUrl, // تم إضافة هذا
    required this.cancelUrl, // تم إضافة هذا
  });

  Map<String, dynamic> toJson() {
    return {
      'intent': intent,
      'payer': {'payment_method': 'paypal'},
      'transactions': transactions,
      'redirect_urls': {
        'return_url': returnUrl,
        'cancel_url': cancelUrl,
      },
    };
  }
}


class PaypalServices {
  final ApiServices apiServices;

  final bool sandboxMode;

  PaypalServices({required this.apiServices, this.sandboxMode = true});

  String get _baseUrl => sandboxMode
      ? 'https://api-m.sandbox.paypal.com'
      : 'https://api.paypal.com';

  final Options _defaultOptions =
      Options(headers: {'Content-Type': 'application/json'});

  Future<String> fetchAccessToken() async {
    try {
      final String authToken = base64.encode(utf8
          .encode('${PaypalKeys.clientId}:${PaypalKeys.secretKey}'));
      final Response response = await apiServices.post(
        url: '$_baseUrl/v1/oauth2/token?grant_type=client_credentials',
        options: Options(
          headers: {
            'Authorization': 'Basic $authToken',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      final String? accessToken = response.data?['access_token']?.toString();
      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Failed to retrieve access token from PayPal.');
      }

      return accessToken;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(
            'PayPal credentials incorrect or unauthorized: ${e.response?.data}');
      }
      throw Exception(
          'Failed to connect to PayPal API to fetch access token: ${e.message}');
    } catch (e) {
      throw Exception(
          'An unknown error occurred while fetching PayPal access token: $e');
    }
  }

  Future<PaypalPaymentLinks> createPaypalPayment({
    required PaypalTransactionModel paypalTransaction,
    required String accessToken,
  }) async {
    try {
      final Response response = await apiServices.post(
        url: '$_baseUrl/v1/payments/payment',
        data: paypalTransaction.toJson(),
        options: _defaultOptions.copyWith(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      print('PaypalServices.createPaypalPayment :${response.data}  ');
      final Map<String, dynamic> responseData = response.data;
      if (responseData['links'] != null && responseData['links'].isNotEmpty) {
        final List<dynamic> links = responseData['links'];

        final String? approvalUrl = links.firstWhere(
          (o) => o['rel'] == 'approval_url',
          orElse: () => null,
        )?['href'];
        final String? executeUrl = links.firstWhere(
          (o) => o['rel'] == 'execute',
          orElse: () => null,
        )?['href'];

        if (approvalUrl == null || executeUrl == null) {
          throw Exception(
              'PayPal payment links (approval_url or execute) not found in response.');
        }
        //  PaypalKeys.executeUrl = executeUrl;
        return PaypalPaymentLinks(
          approvalUrl: approvalUrl,
          executeUrl: executeUrl,
        );
      } else {
        throw Exception(
            'No payment links found in PayPal create payment response.');
      }
    } on DioException catch (e) {
      throw Exception(
          'Failed to create PayPal payment: ${e.response?.data ?? e.message}');
    } catch (e) {
      rethrow; // إعادة رمي أي استثناءات أخرى غير متعلقة بـ Dio
    }
  }

  PaypalPaymentIntentResponse? paymentIntentResponse;

  Future<PaypalPaymentIntentResponse> createPaymentIntent({
    required PaypalTransactionModel paypalTransaction,
  }) async {
    final String accessToken = await fetchAccessToken();
    final PaypalPaymentLinks paymentResponseModel =
        await createPaypalPayment(
            paypalTransaction: paypalTransaction, accessToken: accessToken);
    paymentIntentResponse = PaypalPaymentIntentResponse(
      accessToken: accessToken,
      paypalPaymentLinks: paymentResponseModel,
    );

    return paymentIntentResponse!;
  }

  Future<Map<String, dynamic>> executePaypalPayment({
    required String executeUrl,
    required String payerId,

    required String accessToken,
  }) async {

      final Response response = await apiServices.post(
        url: executeUrl,
        data: {'payer_id': payerId},
        options: _defaultOptions.copyWith(
          headers: {
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      final Map<String, dynamic> responseData = response.data;
      print('PaypalServices.executePaypalPayment  $responseData');
      final Map<String, dynamic> payerInfo = responseData['payer']['payer_info'];
      final String? payerEmail = payerInfo['email'];
      if (responseData['state'] == 'approved') {
        return {
          'success': true,
          'message': 'Payment approved',
          'data': responseData,
          'payerEmail':payerEmail,
        };
      } else {
        return {
          'success': false,
          'message': 'Payment not approved',
          'data': responseData
        };
      }
  }
}

class PaypalPaymentIntentResponse {
  final String accessToken;
  final PaypalPaymentLinks paypalPaymentLinks;

  PaypalPaymentIntentResponse(
      {required this.accessToken, required this.paypalPaymentLinks});
}

class PaypalPaymentLinks {
  final String approvalUrl;
  final String executeUrl;

  PaypalPaymentLinks(
      {required this.approvalUrl, required this.executeUrl});
}