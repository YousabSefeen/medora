


import 'package:medora/core/payment_gateway_manager/stripe_payment/stripe_keys.dart' show StripeKeys;
import 'package:medora/features/payment_gateways/stripe/data/models/create_user_model.dart' show CreateUserModel;
import 'package:medora/features/payment_gateways/stripe/data/models/payment_intent_model.dart' show PaymentIntentModel;

class StripeDummyDataService{

  static   PaymentIntentModel get paymentIntentModel => PaymentIntentModel(
    currency: 'USD',
    amount: 100,
    customerId:  StripeKeys.customerId,
  );
  static  CreateUserModel get createUserModel => CreateUserModel(
    name: 'Yousab 55',
    email: 'yousabsefeen55@gmail.com',
    phone: '01227155559',
  );
}