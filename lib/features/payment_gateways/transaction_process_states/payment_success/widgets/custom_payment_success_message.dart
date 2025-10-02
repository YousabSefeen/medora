import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class CustomPaymentSuccessMessage extends StatelessWidget {
  const CustomPaymentSuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        'Booking Successfully!',
        textAlign: TextAlign.center,
        style:  Theme.of(context).textTheme.robotoBoldStyle
      ),
    );
  }
}
