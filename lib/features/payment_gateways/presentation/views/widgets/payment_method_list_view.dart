// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:flutter_task/features/payment_gateways/presentation/views/widgets/payment_method_card.dart';
// import 'package:flutter_task/features/payment_gateways/presentation/views/widgets/subtitle_widget.dart';
//
// import 'package:provider/provider.dart';
//
// import '../../../../../core/constants/app_strings/app_strings.dart';
// import '../../../../../core/enum/payment_gateways_types.dart';
// import '../../../../../generated/assets.dart';
// import '../../Controller/payment_gateways_provider.dart';
// import '../../controller/cubit/payment_gateways_cubit.dart';
// import '../../controller/states/payment_gateways_state.dart';
//
//
//
// class PaymentMethodListView extends StatelessWidget {
//
//
//
//  final TextEditingController phoneNumberController;
//
//
//   const PaymentMethodListView({super.key , required this.phoneNumberController});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  BlocSelector<PaymentGatewaysCubit,PaymentGatewaysState, PaymentGatewaysTypes>(
//       selector: (state)=> state.paymentMethod,
//
//       builder: (context, paymentMethod ) {
//
//
//         return SizedBox(
//
//           child: Column(
//
//             children: [
//               PaymentMethodCard(
//             paymentMethodName:AppStrings.onlineCard,
//             subtitleWidget: SubtitleWidget(
//               index:0,
//               isPaymentSelected:paymentMethod ==PaymentGatewaysTypes.paymobCard,
//               phoneNumberController: phoneNumberController,
//             ),
//             logoPath: Assets.imagesOnlineCard,
//
//             isSelected:paymentMethod ==PaymentGatewaysTypes.paymobCard,
//             value: PaymentGatewaysTypes.paymobCard.name,
//             groupValue: paymentMethod.name,
//             onChanged: (String? newValue) {
//               context
//                   .read<PaymentGatewaysCubit>()
//                   .onChangePaymentMethod(PaymentGatewaysTypes.paymobCard);
//             },
//           ),
//
//               PaymentMethodCard(
//                 paymentMethodName:AppStrings.mobileWallets,
//                 subtitleWidget: SubtitleWidget(
//                   index:1,
//                   isPaymentSelected:paymentMethod ==PaymentGatewaysTypes.paymobMobileWallets,
//                   phoneNumberController: phoneNumberController,
//                 ),
//                 logoPath: Assets.imagesMobileWalletsLogo,
//
//                 isSelected:paymentMethod ==PaymentGatewaysTypes.paymobMobileWallets,
//                 value: PaymentGatewaysTypes.paymobMobileWallets.name,
//                 groupValue: paymentMethod.name,
//                 onChanged: (String? newValue) {
//                   context
//                       .read<PaymentGatewaysCubit>()
//                       .onChangePaymentMethod(PaymentGatewaysTypes.paymobMobileWallets);
//                 },
//               ),
//
//               PaymentMethodCard(
//                 paymentMethodName:AppStrings.stripe,
//                 subtitleWidget: SubtitleWidget(
//                   index:0,
//                   isPaymentSelected:paymentMethod ==PaymentGatewaysTypes.stripe,
//                   phoneNumberController: phoneNumberController,
//                 ),
//                 logoPath: Assets.imagesStripe,
//
//                 isSelected:paymentMethod ==PaymentGatewaysTypes.stripe,
//                 value: PaymentGatewaysTypes.stripe.name,
//                 groupValue: paymentMethod.name,
//                 onChanged: (String? newValue) {
//                   context
//                       .read<PaymentGatewaysCubit>()
//                       .onChangePaymentMethod(PaymentGatewaysTypes.stripe);
//                 },
//               ),
//               PaymentMethodCard(
//                 paymentMethodName:AppStrings.payPal,
//                 subtitleWidget: SubtitleWidget(
//                   index:0,
//                   isPaymentSelected:paymentMethod ==PaymentGatewaysTypes.payPal,
//                   phoneNumberController: phoneNumberController,
//                 ),
//                 logoPath: Assets.imagesPayPal,
//
//                 isSelected:paymentMethod ==PaymentGatewaysTypes.payPal,
//                 value: PaymentGatewaysTypes.payPal.name,
//                 groupValue: paymentMethod.name,
//                 onChanged: (String? newValue) {
//                   context
//                       .read<PaymentGatewaysCubit>()
//                       .onChangePaymentMethod(PaymentGatewaysTypes.payPal);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//
//
//   }
// }
