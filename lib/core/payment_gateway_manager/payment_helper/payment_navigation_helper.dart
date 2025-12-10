import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;

class PaymentNavigationHelper {
  static void popWithPaymentCancelledResult(BuildContext context) {
    Navigator.pop(context, AppStrings.paymentCancelledError);
  }
}
