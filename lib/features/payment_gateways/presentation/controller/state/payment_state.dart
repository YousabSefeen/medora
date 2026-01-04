import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;


class PaymentState extends Equatable {

  final PaymentGatewaysTypes selectedPaymentMethod;

  const PaymentState({

    this.selectedPaymentMethod = PaymentGatewaysTypes.none,
  });

  PaymentState copyWith({

    PaymentGatewaysTypes? selectedPaymentMethod,
  }) => PaymentState(

      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );

  @override
  List<Object?> get props => [ selectedPaymentMethod];
}
