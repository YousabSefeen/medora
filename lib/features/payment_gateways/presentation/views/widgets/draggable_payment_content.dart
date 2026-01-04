// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_task/core/enum/payment_gateways_types.dart';
// import 'package:flutter_task/features/payment_gateways/paymob/data/data/order_details.dart';
// import 'package:flutter_task/features/payment_gateways/paymob/presentation/view/screens/paymob_initialization_screen.dart';
// import 'package:flutter_task/features/payment_gateways/presentation/controller/cubit/payment_cubit.dart';
// import 'package:flutter_task/features/payment_gateways/presentation/controller/states/payment_state.dart';
// import 'package:flutter_task/features/payment_gateways/presentation/views/widgets/payment_method_list_view.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../Core/payment_gateway_manager/stripe_payment/stripe_keys.dart';
// import '../../../../../core/animations/custom_animation_route.dart';
// import '../../../../../core/constants/app_alerts/app_alerts.dart';
// import '../../../../../core/constants/app_strings/app_strings.dart';
// import '../../../../../core/enum/payment_status.dart';
// import '../../../paypal/presentation/views/screens/paypal_payment_by_package_screen.dart';
// import '../../../stripe/Presentation/Controller/stripe_payment_provider.dart';
// import '../../../transaction_process_states/payment_failed/screens/payment_failed_screen.dart';
// import '../../../transaction_process_states/payment_success/screens/payment_success_screen.dart';
// import '../../Controller/payment_gateways_provider.dart';
// import 'continue_button.dart';
//
// class DraggablePaymentContent extends StatelessWidget {
//   final OrderDetails orderDetails;
//
//   const DraggablePaymentContent({super.key, required this.orderDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     final phoneNumberController = TextEditingController();
//     return BlocSelector<PaymentGatewaysCubit, PaymentGatewaysState,
//         PaymentGatewaysTypes>(
//       selector: (state) => state.paymentMethod,
//       builder: (context, paymentMethod) {
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               PaymentMethodListView(
//                 phoneNumberController: phoneNumberController,
//               ),
//               ContinueButton(
//                 paymentMethodNone: paymentMethod == PaymentGatewaysTypes.none,
//                 onPressed: () => _handlePaymentSelection(
//                   context: context,
//                   selectedPaymentMethod: paymentMethod,
//                   orderDetails: orderDetails,
//                   phoneNumberController: phoneNumberController.text.trim(),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _handlePaymentSelection(
//       {required BuildContext context,
//       required PaymentGatewaysTypes selectedPaymentMethod,
//       required OrderDetails orderDetails,
//       required String phoneNumberController}) async {
//     switch (selectedPaymentMethod) {
//       case PaymentGatewaysTypes.none:
//         return;
//       case PaymentGatewaysTypes.paymobMobileWallets:
//         _paymentByPhoneNumber(
//           context: context,
//           orderDetails: orderDetails,
//           selectedPaymentMethod: selectedPaymentMethod,
//           phoneNumber: phoneNumberController,
//         );
//       case PaymentGatewaysTypes.paymobCard:
//         _paymentByCard(
//           context: context,
//           orderDetails: orderDetails,
//           selectedPaymentMethod: selectedPaymentMethod,
//         );
//       case PaymentGatewaysTypes.stripe:
//         await _paymentByStripe(context);
//       case PaymentGatewaysTypes.payPal:
//         _paymentByPaypal(context);
//     }
//   }
//
//   void _navigateAndClearStack(BuildContext context, Widget screen) {
//     Navigator.of(context).pushAndRemoveUntil(
//       CustomAnimationRoute(screen: screen),
//       (_) => false,
//     );
//   }
//
//   void _paymentByCard(
//           {required BuildContext context,
//     required PaymentGatewaysTypes selectedPaymentMethod,
//     required OrderDetails orderDetails,
//   }) =>
//       _navigateAndClearStack(
//         context,
//         PaymobInitializationScreen(
//           selectedPaymentMethod: selectedPaymentMethod,
//           orderDetails: orderDetails,
//         ),
//       );
//
//   void _paymentByPhoneNumber({
//     required BuildContext context,
//     required PaymentGatewaysTypes selectedPaymentMethod,
//     required OrderDetails orderDetails,
//     required String phoneNumber,
//   }) async {
//     if (phoneNumber.isEmpty) {
//       AppAlerts.customErrorSnackBar(
//         context: context,
//         msg: AppStrings.enterPhoneNumberError,
//       );
//     } else if (phoneNumber.length != 10) {
//       AppAlerts.customErrorSnackBar(
//         context: context,
//         msg: AppStrings.invalidPhoneNumberError,
//       );
//     } else {
//       _navigateAndClearStack(
//         context,
//         PaymobInitializationScreen(
//             selectedPaymentMethod: selectedPaymentMethod,
//           orderDetails: orderDetails,
//           phoneNumber: phoneNumber,
//         ),
//       );
//     }
//   }
//
//   Future<void> _paymentByStripe(BuildContext context) async {
//     context.read<PaymentGatewaysProvider>().updateLoadingState(true);
//     final stripeProvider =
//         Provider.of<StripePaymentProvider>(context, listen: false);
//
//     await _processStripePayment(stripeProvider);
//
//     if (!context.mounted) return;
//
//     _handleStripePaymentResult(context, stripeProvider);
//
//     context.read<PaymentGatewaysProvider>().updateLoadingState(false);
//   }
//
//   /// Execute the payment process via Stripe
//   Future<void> _processStripePayment(
//       StripePaymentProvider stripeProvider) async {
//     await stripeProvider.stripePaymentProcess(
//       paymentIntentModel: StripeKeys.paymentIntentModel,
//       createUserModel: StripeKeys.createUserModel,
//     );
//   }
//
//   /// Handle the Stripe payment result and display the error message if any
//   void _handleStripePaymentResult(
//       BuildContext context, StripePaymentProvider stripeProvider) {
//     if (stripeProvider.stripeState == PaymentStates.success) {
//       _handleStripePaymentSuccess(context);
//     } else if (stripeProvider.stripeState == PaymentStates.error) {
//       _handleStripePaymentFailure(stripeProvider, context);
//     }
//   }
//
//   void _handleStripePaymentSuccess(BuildContext context) =>
//       _navigateAndClearStack(
//           context, const PaymentSuccessScreen(paymentMethod: 'stripe'));
//
//   void _handleStripePaymentFailure(
//       StripePaymentProvider stripeProvider, BuildContext context) {
//     final error = 'The payment has been cancelled.';
//     if (stripeProvider.stripeErrorMessage == error) {
//       AppAlerts.customErrorSnackBar(context: context, msg: error);
//     } else {
//       _navigateAndClearStack(
//           context,
//           PaymentFailedScreen(
//             paymentMethod: 'stripe',
//             errorMessage: stripeProvider.stripeErrorMessage,
//           ));
//     }
//   }
//
//   _paymentByPaypal(BuildContext context) =>
//       _navigateAndClearStack(context, const PaypalPaymentScreen());
// }
