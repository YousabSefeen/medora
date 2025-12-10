import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medora/core/payment_gateway_manager/stripe_payment/stripe_keys.dart'
    show StripeKeys;
import 'package:medora/features/payment_gateways/stripe/data/models/create_user_model.dart'
    show CreateUserModel;
import 'package:medora/features/payment_gateways/stripe/data/models/payment_intent_model.dart'
    show PaymentIntentModel;

import '../../../features/payment_gateways/stripe/data/models/ephemeral_key_model.dart';
import '../../services/api_services.dart';

class StripeServices {
  final ApiServices apiServices;

  StripeServices({required this.apiServices});

  //TODO ( Optional ) Create user in stripe DashBord
  /// This function is called once when a user creates an account at the start of the application
  ///TODO Or when they try to pay for the first time and the user's data is fetched from the backend.
  /// It registers the user's data in the stripe dashboard and generates a unique user ID.
  /// The resulting user ID (userIdInStripe) is then stored in the user information database.
  Future<CreateUserModel> createUserInStripeDashboard({
    required CreateUserModel createUserModel,
  }) async {
    final Response response = await apiServices.post(
      url: StripeKeys.createUser,
      token: StripeKeys.secretKey,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer ${StripeKeys.secretKey}'},
      ),
      data: createUserModel.toJson(),
    );

    return CreateUserModel.fromJson(response.data);
  }

  // TODO ( Optional) getEphemeralKeys
  /// Generates a new Ephemeral Key for the user's stripe account (userIdInStripe) during each payment attempt.
  /// The key is passed to the initPaymentSheet function as customerEphemeralKeySecret, enabling secure access to saved payment methods.
  /// This approach ensures up-to-date payment data and avoids key expiration issues, with optional caching for performance optimization.
  Future<EphemeralKeyModel> getEphemeralKeys({
    required String customerId,
  }) async {
    final Response response = await apiServices.post(
      url: StripeKeys.ephemeralKeys,
      data: {'customer': customerId},
      token: StripeKeys.secretKey,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'stripe-Version': '2024-12-18.acacia',
        },
      ),
    );

    return EphemeralKeyModel.fromJson(response.data);
  }

  //TODO( Required Step 1) This function initializes the payment intent and retrieves the paymentIntentClientSecret,
  // which will be passed to the initPaymentSheet method for setting up the payment process.
  Future<PaymentIntentModel> createPaymentIntent({
    required int totalPrice,
  }) async {
    final Response response = await apiServices.post(
      url: StripeKeys.paymentIntent,
      data: {
        'amount': ((totalPrice / 49.5) * 100).toInt(),
        'currency': 'USD',
        'customer': StripeKeys.customerId,
      },
      token: StripeKeys.secretKey,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer ${StripeKeys.secretKey}'},
      ),
    );

    return PaymentIntentModel.fromJson(response.data);
  }

  //TODO( Required Step 2) initPaymentSheet from docs

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
    required EphemeralKeyModel ephemeralKeyModel,
  }) async {
    // 2. initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        //TODO Main params
        //Displays the merchant's name to the user during the payment process.
        merchantDisplayName: 'Flutter stripe Store Demo',
        //   paymentIntentClientSecret: Secret key for securely processing the payment intent From (Response createPaymentIntent() ).
        paymentIntentClientSecret: paymentIntentClientSecret,
        //TODO   Customer keys
        //       Unique identifier for the customer in stripe, linking the payment to the correct account.
        customerId: StripeKeys.customerId,
        //   Ephemeral key associated with the user, ensuring secure access to saved payment methods.
        customerEphemeralKeySecret: ephemeralKeyModel.secret,

        // Extra options
        style: ThemeMode.dark,
      ),
    );
  }

  //TODO( Required Step 3) presentPaymentSheet from docs
  // Displays the payment sheet to the user for completing the payment process.
  // This method also handles payment confirmation once the user selects or provides a payment method.
  Future presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future makePayment({
    required int totalPrice,
    required CreateUserModel createUserModel,
  }) async {
    /* final CreateUserModel responseUser =
        await createUserInStripeDashboard(createUserModel: createUserModel);*/

    final PaymentIntentModel responsePaymentIntent = await createPaymentIntent(
      totalPrice: totalPrice,
    );

    final EphemeralKeyModel ephemeralKey = await getEphemeralKeys(
      customerId: StripeKeys.customerId,
    );

    await initPaymentSheet(
      paymentIntentClientSecret: responsePaymentIntent.clientSecret!,
      ephemeralKeyModel: ephemeralKey,
    );

    await presentPaymentSheet();
  }
}
