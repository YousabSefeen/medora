import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/payment_gateways/presentation/controller/state/payment_state.dart'
    show PaymentState;

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());


  void onChangePaymentMethod(PaymentGatewaysTypes paymentMethod) =>
      emit(state.copyWith(selectedPaymentMethod: paymentMethod));
}
