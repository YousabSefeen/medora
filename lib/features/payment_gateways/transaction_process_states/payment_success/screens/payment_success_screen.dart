import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataModel;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/appointment_details_success_card.dart'
    show AppointmentDetailsSuccessCard;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/bottom_action_button_section.dart'
    show BottomActionButtonSection;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_check_icon.dart'
    show CustomCheckIcon;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_dashed_line_divider.dart'
    show CustomDashedLineDivider;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_payment_success_message.dart'
    show CustomPaymentSuccessMessage;

class PaymentSuccessScreen extends StatelessWidget {
  final PaymentGatewaysTypes paymentMethod;
  final PaymobTransactionDataModel? paymobResponseModel;
  final String? paypalPayerEmail;

  const PaymentSuccessScreen({
    super.key,
    required this.paymentMethod,
    this.paymobResponseModel,
    this.paypalPayerEmail,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _navigateToDoctorList(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffC0C9EE),
        appBar: AppBar(backgroundColor: Colors.transparent),
        bottomNavigationBar: const BottomActionButtonSection(),
        body: const _PaymentSuccessBody(),
      ),
    );
  }

  void _navigateToDoctorList(BuildContext context) =>
      AppRouter.pushAndRemoveUntil(context, const BottomNavScreen());
}

class _PaymentSuccessBody extends StatelessWidget {
  const _PaymentSuccessBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: ShapeDecoration(
          color: AppColors.softBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            side: const BorderSide(color: AppColors.white),
          ),
        ),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              CustomCheckIcon(),
              CustomPaymentSuccessMessage(),
              SizedBox(height: 10),
              CustomDashedLineDivider(),
              AppointmentDetailsSuccessCard(),
            ],
          ),
        ),
      ),
    );
  }
}
