import 'package:flutter/material.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_dashed_line.dart'
    show CustomDashedLine;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_half_circle.dart'
    show CustomHalfCircle;

class CustomDashedLineDivider extends StatelessWidget {
  const CustomDashedLineDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomHalfCircle(isLeftPosition: true),
        CustomDashedLine(),
        CustomHalfCircle(isLeftPosition: false),
      ],
    );
  }
}
