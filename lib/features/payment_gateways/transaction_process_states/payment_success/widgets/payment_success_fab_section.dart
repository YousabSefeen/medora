import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/context_padding_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart';
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';

class PaymentSuccessFABSection extends StatelessWidget {
  const PaymentSuccessFABSection({super.key});

  static const double _horizontalSpacing = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(
        top: 25,
        left: _horizontalSpacing,
        right: _horizontalSpacing,
      ),
      margin: EdgeInsets.only(
        bottom: context.bottomSafePadding,
        left: _horizontalSpacing,
        right: _horizontalSpacing,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_TotalAmountSection(), SizedBox(height: 10), _DoneButton()],
      ),
    );
  }
}

class _TotalAmountSection extends StatelessWidget {
  const _TotalAmountSection();

  @override
  Widget build(BuildContext context) {
    final doctorFees = context
        .read<BookAppointmentCubit>()
        .bookingDetails
        .doctorEntity
        .fees;
    final textTheme = context.textTheme;

    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: AppStrings.total,
              style: textTheme.largeBlackBold.copyWith(letterSpacing: 2),
              children: [
                TextSpan(
                  text: '$doctorFees ${AppStrings.egyptianCurrency}',
                  style: textTheme.numbersStyle.copyWith(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black45, thickness: 1),
        ],
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton();

  @override
  Widget build(BuildContext context) {
    return AdaptiveActionButton(
      title: AppStrings.done,
      isLoading: false,
      isEnabled: true,
      onPressed: () => _navigateToDoctorList(context),
    );
  }

  void _navigateToDoctorList(BuildContext context) {
    context.read<UpcomingAppointmentsCubit>().refreshData();
    AppRouter.pushAndRemoveUntil(context, const BottomNavScreen());
  }
}
