import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class CancelAppointmentState extends Equatable {
  final LazyRequestState requestState;
  final String failureMessage;

  const CancelAppointmentState({
    this.requestState = LazyRequestState.lazy,
    this.failureMessage = '',
  });

  CancelAppointmentState copyWith({
    LazyRequestState? requestState,
    String? failureMessage,
  }) {
    return CancelAppointmentState(
      requestState: requestState ?? this.requestState,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override

  List<Object?> get props => [
    requestState,
    failureMessage,
  ];
}
