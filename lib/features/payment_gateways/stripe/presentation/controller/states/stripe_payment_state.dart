import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class StripePaymentState extends Equatable {
  final String payErrorMessage;
  final LazyRequestState payRequestState;

  const StripePaymentState({
    this.payErrorMessage = '',
    this.payRequestState = LazyRequestState.lazy,
  });

  StripePaymentState copyWith({
    String? payErrorMessage,
    LazyRequestState? payRequestState,
  }) {
    return StripePaymentState(
      payErrorMessage: payErrorMessage ?? this.payErrorMessage,
      payRequestState: payRequestState ?? this.payRequestState,
    );
  }

  @override
  List<Object?> get props => [payErrorMessage, payRequestState];
}
