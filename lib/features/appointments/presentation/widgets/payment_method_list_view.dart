import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings, PaymentMethod;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart' show AppointmentCubit;

import '../../../../core/enum/payment_gateways_types.dart';
import '../../../payment_gateways/presentation/views/widgets/payment_method_card.dart';


class PaymentMethodListView extends StatelessWidget {
  final TextEditingController? phoneNumberController;
  final PaymentGatewaysTypes selectedPaymentMethod;

  const PaymentMethodListView({
    super.key,
    this.phoneNumberController,
   required this.selectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.55,
      child: ListView.builder(
        itemCount: AppStrings.paymentOptions.length,
        itemBuilder: (context, index) {
          final paymentOption = AppStrings.paymentOptions[index];

          return _buildPaymentMethodCard(
            context: context,
            paymentMethod: paymentOption,
            isSelected: selectedPaymentMethod == paymentOption.value,
            selectedMethodName: selectedPaymentMethod.name,
          );
        },
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required BuildContext context,
    required PaymentMethod paymentMethod,
    required bool isSelected,
    required String selectedMethodName,
  }) {
    return PaymentMethodCard(
      phoneNumberController: phoneNumberController,
      value: paymentMethod.value.name,
      groupValue: selectedMethodName,
      onChanged: (String? newValue) {
        context
            .read<AppointmentCubit>()
            .onChangePaymentMethod(paymentMethod.value);
      },
      isSelected: isSelected,
      paymentMethod: paymentMethod,
    );
  }
}