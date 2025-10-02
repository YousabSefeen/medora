// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_task/features/payment_gateways/presentation/views/widgets/phone_number_field.dart';
//
// import '../../../../../core/constants/app_strings/app_strings.dart';
// import 'custom_animation_widget.dart';
//
// class SubtitleWidget extends StatelessWidget {
//   final int index;
//   final TextEditingController phoneNumberController;
//   final bool isPaymentSelected;
//
//   const SubtitleWidget(
//       {super.key,
//       required this.index,
//       required this.isPaymentSelected,
//       required this.phoneNumberController});
//
//   @override
//   Widget build(BuildContext context) {
//     if (index == 1 && isPaymentSelected) {
//       return CustomAnimationWidget(
//         endPosition: 1,
//         color: Colors.white,
//         child: PhoneNumberField(
//           controller: phoneNumberController,
//         ),
//       );
//     } else {
//       return Text(
//         AppStrings.paymentOptions[index].subtitle,
//         style: TextStyle(
//           fontSize: 12.sp,
//           color: isPaymentSelected ? Colors.white : Colors.grey.shade600,
//           fontWeight: FontWeight.w500,
//         ),
//       );
//     }
//   }
// }
