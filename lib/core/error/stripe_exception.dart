import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:medora/core/constants/app_strings/app_errors_strings.dart';

class StripeFailure {
  final Object catchError;

  StripeFailure({required this.catchError});

  String get errorMessage {
    final stripeError = catchError as StripeException;
    stripeError.error.localizedMessage;
    switch (stripeError.error.code) {
      case FailureCode.Failed:
        return AppErrorsStrings.stripePaymentFailed;
      case FailureCode.Canceled:
        return AppErrorsStrings.paymentCanceled;
      case FailureCode.Timeout:
        return AppErrorsStrings.stripePaymentTimeout;
      case FailureCode.Unknown:
        return AppErrorsStrings.stripePaymentUnknown;
    }
  }

  @override
  String toString() {
    return errorMessage;
  }
}
