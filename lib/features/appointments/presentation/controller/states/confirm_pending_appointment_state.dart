import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;

class ConfirmPendingAppointmentState extends Equatable {
  final LazyRequestState confirmAppointmentState;
  final String? confirmAppointmentError;
  final PaymentGatewaysTypes? selectedPaymentMethod;

  const ConfirmPendingAppointmentState({
    this.confirmAppointmentState = LazyRequestState.loading,
    this.confirmAppointmentError = '',
    this.selectedPaymentMethod,
  });

  ConfirmPendingAppointmentState copyWith({
    LazyRequestState? confirmAppointmentState,
    String? confirmAppointmentError,
    PaymentGatewaysTypes? selectedPaymentMethod,
  }) {
    return ConfirmPendingAppointmentState(
      confirmAppointmentState:
          confirmAppointmentState ?? this.confirmAppointmentState,
      confirmAppointmentError:
          confirmAppointmentError ?? this.confirmAppointmentError,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    confirmAppointmentState,
    confirmAppointmentError,
    selectedPaymentMethod,
  ];
}
