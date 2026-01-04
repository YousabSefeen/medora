import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/appointments/presentation/widgets/pay_now_button.dart'
    show PayNowButton;
import 'package:medora/features/appointments/presentation/widgets/payment_method_list_view.dart'
    show PaymentMethodListView;
import 'package:medora/features/payment_gateways/presentation/controller/cubit/payment_cubit.dart'
    show PaymentCubit;
import 'package:medora/features/payment_gateways/presentation/controller/state/payment_state.dart'
    show PaymentState;

/// Bottom sheet for selecting available payment methods
///
/// This screen allows the user to choose their preferred payment method from:
/// - Paymob (Mobile Wallets or Cards)
/// - Stripe (International Cards)
/// - PayPal (PayPal account)
///
/// After selection, the user presses "Pay Now" to start the booking and payment process
class PaymentSelectionSheet extends StatefulWidget {
  const PaymentSelectionSheet({super.key});

  @override
  State<PaymentSelectionSheet> createState() => _PaymentSelectionSheetState();
}

class _PaymentSelectionSheetState extends State<PaymentSelectionSheet> {
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PaymentCubit, PaymentState, PaymentGatewaysTypes>(
      selector: (state) => state.selectedPaymentMethod,
      builder: (context, selectedPaymentMethod) => Column(
        children: [
          PaymentMethodListView(
            selectedPaymentMethod: selectedPaymentMethod,
            phoneNumberController: phoneNumberController,
          ),
          PayNowButton(phoneNumberController: phoneNumberController),
        ],
      ),
    );
  }
}
