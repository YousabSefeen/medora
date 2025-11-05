import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;

class StripeFailure {
  final Object catchError;

  StripeFailure({required this.catchError});

  String get errorMessage {
    if (catchError is StripeException) {
      final stripeError = catchError as StripeException;

      if (stripeError.error.code == FailureCode.Canceled) {
        return AppStrings.paymentCancelledError;
      }

      return 'Payment failed with error: ${stripeError.error.localizedMessage}';
    }

    return 'An unexpected error occurred: ${catchError.toString()}';
  }

  @override
  String toString() {
    return errorMessage;
  }
}
