import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show PaymentMethod;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/payment_gateways/presentation/views/widgets/phone_number_field.dart'
    show PhoneNumberField;

import 'custom _image_widget.dart';
import 'custom_animation_widget.dart';

class PaymentMethodCard extends StatelessWidget {
  final TextEditingController? phoneNumberController;
  final String value;
  final String? groupValue;
  final bool isSelected;
  final void Function(String?)? onChanged;
  final PaymentMethod paymentMethod;

  const PaymentMethodCard({
    super.key,
    required this.value,
    required this.groupValue,
    required this.isSelected,
    this.onChanged,
    required this.paymentMethod,
    this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: CustomAnimationWidget(
        endPosition: isSelected ? 1.0 : 0.9,
        color: isSelected ? Colors.black87 : Colors.transparent,
        child: Card(
          elevation: 5,
          color: isSelected ? AppColors.customBlue : Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: const BorderSide(color: Colors.grey),
          ),
          child: RadioListTile<String>(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            secondary: CustomImageWidget(image: paymentMethod.logo),
            activeColor: Colors.white,
            splashRadius: 20,
            title: _buildPaymentTitle(),
            subtitle: _buildPaymentSubtitle(),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTitle() => Text(
    paymentMethod.name,
    style: GoogleFonts.poppins(
      fontSize: 15.sp,
      color: isSelected ? Colors.white : Colors.black,
      fontWeight: FontWeight.w800,
    ),
  );

  Widget _buildPaymentSubtitle() {
    final isWallet =
        paymentMethod.value == PaymentGatewaysTypes.paymobMobileWallets;
    if (isWallet && isSelected) {
      return CustomAnimationWidget(
        endPosition: 1,
        color: Colors.white,
        child: PhoneNumberField(controller: phoneNumberController!),
      );
    }

    return Text(
      paymentMethod.subtitle,
      style: TextStyle(
        fontSize: 12.sp,
        color: isSelected ? Colors.white : Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
