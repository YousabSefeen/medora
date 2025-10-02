// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import 'package:provider/provider.dart';
//
// import '../../Controller/payment_gateways_provider.dart';
//
// class PaymentMethodAppBar extends StatelessWidget {
//   const PaymentMethodAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.sizeOf(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           width: deviceSize.width * 0.12,
//           child: IconButton(
//               onPressed: () {
//                 context
//                     .read<PaymentGatewaysProvider>()
//                     .removeSelectedPaymentMethod();
//
//                 Future.delayed(const Duration(milliseconds: 300), () {
//                   if (context.mounted) {
//                     Navigator.pop(context);
//                   }
//                 });
//               },
//               icon: FaIcon(
//                 FontAwesomeIcons.arrowLeft,
//                 size: 20.sp,
//                 color: Colors.black,
//               )),
//         ),
//         Expanded(
//             child: Text(
//           'Payment Method',
//           style: TextStyle(fontSize: 18.sp, color: Colors.black),
//           textAlign: TextAlign.center,
//         )),
//         // This SizeBox is added only to balance the elements inside the Row,
//         // so that the text appears perfectly centered. Without having an element
//         // on the right side, the text would shift slightly to the left due to the
//         // presence of the back button on the left only.
//         SizedBox(width: deviceSize.width * 0.12)
//       ],
//     );
//   }
// }
