// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_task/core/constants/themes/app_colors.dart';
// import 'package:flutter_task/features/payment_gateways/paypal/transaction_process_states/presentation/widgets/paypal_payment_method_info.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../transaction_process_states/payment_success/widgets/custom_back_button.dart';
// import '../../../../transaction_process_states/payment_success/widgets/custom_check_icon.dart';
// import '../../../../transaction_process_states/payment_success/widgets/custom_payment_success_message.dart';
// import '../../../../transaction_process_states/payment_success/widgets/order_success_info.dart';
// import '../../data/models/paypal_payment_response_model.dart';
//
// class PaypalSuccessTransactionData extends StatelessWidget {
//   final PaypalPaymentResponseModel  paymentResponseModel;
//   const PaypalSuccessTransactionData({super.key, required this.paymentResponseModel});
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceHeight = MediaQuery.sizeOf(context).height;
//     return Container(
//       width: double.infinity,
//       decoration: ShapeDecoration(
//         color: AppColors.black,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.r),
//             side:   BorderSide(color: AppColors.customBlue)),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 16.h, left: 22, right: 22),
//             child: Column(
//               children: [
//                 SizedBox(
//                   // Sets the height to 31% of the device height (deviceHeight * 0.31)
//                   // to ensure proper alignment with the Custom Half Circle and Custom Dash Line
//                   // in the Thank You screen.
//                   height: deviceHeight * .32,
//                   child: Column(
//                     children: [
//                       SizedBox(height: deviceHeight * 0.03),
//                       const CustomCheckIcon(),
//                       const CustomPaymentSuccessMessage(),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: deviceHeight * 0.33,
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                           OrderSuccessInfo(
//                             title: 'Order ID', sub:paymentResponseModel.data!.payer.payerInfo.email),
//                         const SizedBox(height: 20),
//                         OrderSuccessInfo(
//                           title: 'Date',
//                           sub: _dateNow(),
//                         ),
//                         const SizedBox(height: 20),
//                         OrderSuccessInfo(
//                           title: 'Time',
//                           sub: _timeNow(),
//                         ),
//                         const SizedBox(height: 20),
//                         //  const OrderInfoItem(title: 'To', sub: 'Sam Louis'),
//                         const OrderSuccessInfo(
//                             title: 'Payment Method', sub: ''),
//                         const SizedBox(height: 20),
//                           PaypalPaymentMethodInfo(userEmail: paymentResponseModel.data!.payer.payerInfo.email,),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const Spacer(),
//           Container(
//             padding: const EdgeInsets.only(left: 22, right: 22),
//             decoration: BoxDecoration(
//               color: AppColors.blueShadowHeader,
//               borderRadius:
//               BorderRadius.vertical(bottom: Radius.circular(20.r)),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   height: 3,
//                   width: 75,
//                   margin: const EdgeInsets.only(top: 10),
//                   decoration: ShapeDecoration(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       )),
//                 ),
//                 const Column(
//                   children: [
//                     OrderSuccessInfo(title: 'Total', sub: '110000.0 EGP'),
//                     SizedBox(height: 20),
//                     CustomBackButton(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _dateNow() => DateFormat('dd/MM/yyyy').format(DateTime.now());
//
//   String _timeNow() => DateFormat('h:mm a').format(DateTime.now());
// }
