// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'draggable_payment_content.dart';
//
// class PaymentBottomSheet extends StatelessWidget {
//   const PaymentBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       // required Align to the bottom center
//       alignment: Alignment.bottomCenter,
//       child: Material(
//         color: Colors.black12,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(50.r),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(
//             //This padding is given in this way to display the elements above the keyboard if it is open.
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: const DraggablePaymentContent(),
//         ),
//       ),
//     );
//   }
// }
