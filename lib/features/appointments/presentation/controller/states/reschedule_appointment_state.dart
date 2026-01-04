import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class RescheduleAppointmentState extends Equatable {
  final LazyRequestState requestState;
  final String failureMessage;

  const RescheduleAppointmentState({
    this.requestState = LazyRequestState.lazy,
    this.failureMessage = '',
  });

  RescheduleAppointmentState copyWith({
    LazyRequestState? requestState,
    String? failureMessage,
  }) {
    return RescheduleAppointmentState(
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
