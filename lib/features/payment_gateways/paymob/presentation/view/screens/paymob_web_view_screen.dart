// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_task/core/enum/payment_gateways_types.dart';
// import 'package:flutter_task/core/enum/web_view_status.dart';
// import 'package:flutter_task/core/payment_gateway_manager/web_view_action_state.dart';
// import 'package:flutter_task/features/appointments/presentation/controller/cubit/appointment_cubit.dart';
// import 'package:flutter_task/features/appointments/presentation/controller/states/appointment_state.dart';
// import 'package:flutter_task/features/payment_gateways/transaction_process_states/payment_failed/screens/payment_failed_screen.dart';
// import 'package:flutter_task/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PaymobWebViewScreen extends StatefulWidget {
//   const PaymobWebViewScreen({super.key});
//
//   @override
//   State<PaymobWebViewScreen> createState() => _PaymobWebViewScreenState();
// }
//
// class _PaymobWebViewScreenState extends State<PaymobWebViewScreen> {
//   late final WebViewController webViewController;
//
//   @override
//   void initState() {
//     super.initState();
//     webViewController = WebViewController();
//     context.read<AppointmentCubit>().openWebView(webViewController: webViewController);
//   }
//
//   @override
//   void dispose() {
//     webViewController.clearCache();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<AppointmentCubit, AppointmentState, WebViewActionState>(
//       selector: (state) => WebViewActionState(
//         webViewStatus: state.webViewStatus,
//         webViewErrorMessage: state.webViewErrorMessage,
//         dataResponse: state.transactionResult,
//       ),
//       builder: (context, webViewStatus) {
//         _handeResponseWebView(context, webViewStatus);
//         return Scaffold(
//           appBar: AppBar(),
//           body: WebViewWidget(controller: webViewController),
//         );
//       },
//     );
//   }
//
//   _handeResponseWebView(
//       BuildContext context, WebViewActionState webViewActionState) {
//     switch (webViewActionState.webViewStatus) {
//       case WebViewStatus.init:
//       case WebViewStatus.loading:
//         break;
//       case WebViewStatus.success:
//         _handleSuccess(context, webViewActionState);
//         break;
//       case WebViewStatus.error:
//         _handleError(context, webViewActionState.webViewErrorMessage);
//         break;
//       case WebViewStatus.onHttpError:
//         _handleError(context, webViewActionState.webViewErrorMessage);
//         break;
//       case WebViewStatus.finished:
//         break;
//     }
//   }
//
//   _handleSuccess(BuildContext context, WebViewActionState webViewActionState) {
//     Future.microtask(() {
//       if (!context.mounted) return;
//
//       //ooooooooooooooo
//       // _navigate(
//       //   context,
//       //   PaymentSuccessScreen(
//       //     paymentMethod: PaymentGatewaysTypes.paymobCard,
//       //     paymobResponseModel: webViewActionState.dataResponse,
//       //   ),
//       // );
//
//     });
//     context.read<AppointmentCubit>().clearWebView();
//   }
//
//   _handleError(BuildContext context, errorMessage) => _navigate(
//         context,
//       PaymentFailedScreen(paymentMethod: 'paymob', errorMessage: errorMessage),
//     );
//
//   void _navigate(BuildContext context, Widget screen) =>
//       Navigator.pushAndRemoveUntil(
//           context, MaterialPageRoute(builder: (_) => screen), (_) => false);
// }
