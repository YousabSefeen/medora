import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class CancelAppointmentState extends Equatable {
  final LazyRequestState requestState;
  final String failureMessage;
  final   String    selectedCancellationReason;

  const CancelAppointmentState({
    this.requestState = LazyRequestState.lazy,
    this.failureMessage = '',
    this.selectedCancellationReason='',
  });

  CancelAppointmentState copyWith({
    LazyRequestState? requestState,
    String? failureMessage,
    String? selectedCancellationReason,
  }) {
    return CancelAppointmentState(
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
      selectedCancellationReason: selectedCancellationReason ?? this.selectedCancellationReason,
    );
  }

  @override

  List<Object?> get props => [
    requestState,
    failureMessage,
    selectedCancellationReason,
  ];
}
