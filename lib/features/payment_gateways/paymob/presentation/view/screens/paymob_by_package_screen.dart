// import 'package:flutter/material.dart';
// import 'package:pay_with_paymob/pay_with_paymob.dart';
// import 'package:test_paymob_app/Core/Payment%20Gateway%20Manager/paymob%20payment/paymob_keys.dart';
//
//
// class PaymobByPackageScreen extends StatefulWidget {
//   const PaymobByPackageScreen({super.key});
//
//   @override
//   State<PaymobByPackageScreen> createState() => _PaymobByPackageScreenState();
// }
//
// class _PaymobByPackageScreenState extends State<PaymobByPackageScreen> {
//
//   @override
//   void initState() {
//
//     super.initState();
//     _initializePaymob();
//   }
//
//   _initializePaymob(){
//     PaymentData.initialize(
//       apiKey:PaymobKeys.aPIKey ,
//       iframeId: PaymobKeys.onlineCardIframeId.toString(),
//       integrationCardId: PaymobKeys.integrationOnlineCardId.toString(),
//       integrationMobileWalletId: PaymobKeys.integrationMobileWalletId.toString(),
//
//       // Optional User data
//       userData: UserData(
//         email: "User Email", // Optional: Defaults to 'NA'
//         phone: "User Phone", // Optional: Defaults to 'NA'
//         name: "User First Name", // Optional: Defaults to 'NA'
//         lastName: "User Last Name", // Optional: Defaults to 'NA'
//       ),
//
//       // Optional Style Customizations
//       style: Style(
//         primaryColor: Colors.blue, // Default: Colors.blue
//         scaffoldColor: Colors.white, // Default: Colors.white
//         appBarBackgroundColor: Colors.blue, // Default: Colors.blue
//         appBarForegroundColor: Colors.white, // Default: Colors.white
//         textStyle: TextStyle(), // Default: TextStyle()
//         buttonStyle: ElevatedButton.styleFrom(), // Default: ElevatedButton.styleFrom()
//         circleProgressColor: Colors.blue, // Default: Colors.blue
//         unselectedColor: Colors.grey, // Default: Colors.grey
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return   Scaffold(
//       appBar: AppBar(
//         title: Text('New Screen'),centerTitle: true,
//       ),
//
//     body: Center(
//       child: ElevatedButton(onPressed: (){
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentView(
//               onPaymentSuccess: () {
//                 // Handle payment_success
//               },
//               onPaymentError: () {
//                 // Handle payment failure
//               },
//               price: 100, // Required: Total price (e.g., 100 for 100 EGP)
//             ),
//           ),
//         );
//
//       }, child: Text('data')),
//     ),
//     );
//   }
// }
