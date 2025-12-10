import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;

class BookAppointmentActionState {
  final LazyRequestState bookAppointmentState;
  final String bookAppointmentErrorMessage;
  final PaymentGatewaysTypes selectedPaymentMethod;

  BookAppointmentActionState({
    required this.bookAppointmentState,
    required this.bookAppointmentErrorMessage,
    required this.selectedPaymentMethod,
  });
}
