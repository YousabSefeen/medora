import 'package:medora/core/di/injection_container.dart';
import 'package:medora/core/payment_gateway_manager/paymob_payment/paymob_services.dart'
    show PaymobServices;
import 'package:medora/core/payment_gateway_manager/paypal_payment/paypal_services.dart'
    show PaypalServices;
import 'package:medora/core/payment_gateway_manager/stripe_payment/stripe_services.dart'
    show StripeServices;
import 'package:medora/core/services/api_services.dart';
import 'package:medora/features/payment_gateways/paymob/data/repository/paymob_repository.dart'
    show PaymobRepository;
import 'package:medora/features/payment_gateways/paymob/presentation/controller/cubit/paymob_payment_cubit.dart'
    show PaymobPaymentCubit;
import 'package:medora/features/payment_gateways/paypal/data/repository/paypal_repository.dart'
    show PaypalRepository;
import 'package:medora/features/payment_gateways/paypal/presentation/controller/cubit/paypal_payment_cubit.dart'
    show PaypalPaymentCubit;
import 'package:medora/features/payment_gateways/presentation/controller/cubit/payment_cubit.dart'
    show PaymentCubit;
import 'package:medora/features/payment_gateways/stripe/data/repository/stripe_repository.dart'
    show StripeRepository;
import 'package:medora/features/payment_gateways/stripe/presentation/controller/cubit/stripe_payment_cubit.dart'
    show StripePaymentCubit;

Future<void> initPaymentsDependencies() async {
  // Services & Repositories
  sl.registerLazySingleton(() => ApiServices());

  /// Cubit
  sl.registerFactory<PaymentCubit>(() => PaymentCubit());

  // Paymob
  sl.registerLazySingleton(() => PaymobServices(apiServices: sl()));
  sl.registerLazySingleton(() => PaymobRepository(paymobServices: sl()));
  sl.registerFactory(() => PaymobPaymentCubit(paymobRepository: sl()));

  // Stripe
  sl.registerLazySingleton(() => StripeServices(apiServices: sl()));
  sl.registerLazySingleton(() => StripeRepository(stripeServices: sl()));
  sl.registerFactory(() => StripePaymentCubit(stripeRepo: sl()));

  // Paypal
  sl.registerLazySingleton(() => PaypalServices(apiServices: sl()));
  sl.registerLazySingleton(() => PaypalRepository(paypalServices: sl()));
  sl.registerFactory(() => PaypalPaymentCubit(paypalRepository: sl()));
}
