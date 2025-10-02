import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;



class PopScopeForPaymentGateways extends StatelessWidget {
  final Widget child;


  const PopScopeForPaymentGateways(
      {super.key, required this.child });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          AppRouter.pop(context, returnValue: AppStrings.paymentCancelledError);
        }
      },
      child: child,
    );
  }
}
