import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/lottie_string_asset_ext.dart'
    show LottieStringAssetExtension;
import 'package:medora/features/appointments/presentation/ui_models/appointment_reschedule_ui_model.dart'
    show AppointmentRescheduleUIModel;
import 'package:medora/features/appointments/presentation/widgets/icon_with_text.dart'
    show IconWithText;
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../../core/animations/custom_modal_type_dialog.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/themes/app_colors.dart';
import '../../../../../generated/assets.dart';

abstract class RescheduleSuccessDialog {
  static void show({
    required BuildContext context,
    required AppointmentRescheduleUIModel appointmentReschedule,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => MyCustomModalTypeDialog(),
      barrierDismissible: true,
      onModalDismissedWithBarrierTap: () => context.pop(),
      pageListBuilder: (modalContext) => [
        WoltModalSheetPage(
          backgroundColor: Colors.white,
          hasSabGradient: false,
          topBarTitle: const SizedBox.shrink(),
          isTopBarLayerAlwaysVisible: true,
          topBar: const _SuccessHeaderWidget(),
          navBarHeight: 170.h,
          stickyActionBar: _DoneButtonWidget(onTap: () => modalContext.pop()),
          child: _AppointmentComparisonWidget(
            appointmentReschedule: appointmentReschedule,
          ),
        ),
      ],
    );
  }
}

class _SuccessHeaderWidget extends StatelessWidget {
  const _SuccessHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.lottie.successIconLottie.lottie(
            fit: BoxFit.cover,
            height: 100.h,
          ),
          Text(
            AppStrings.yourAppointment,
            style: TextStyle(
              fontSize: 20.sp,
              color: AppColors.darkBlue,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentComparisonWidget extends StatelessWidget {
  final AppointmentRescheduleUIModel appointmentReschedule;

  const _AppointmentComparisonWidget({required this.appointmentReschedule});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final baseStyle = textTheme.dateTimeBlackStyle.copyWith(fontSize: 15.sp);

    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        bottom: 100.h,
        left: 10.w,
        right: 10.w,
      ),
      child: Column(
        children: [
          _AppointmentCard(
            date: appointmentReschedule.oldAppointmentDate,
            time: appointmentReschedule.oldAppointmentTime,
            style: baseStyle.copyWith(
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.black45,
              decorationThickness: 3,
            ),
            backgroundColor: Colors.grey.shade100,
            borderColor: Colors.black12,
          ),
          SizedBox(height: 12.h),
          FaIcon(
            FontAwesomeIcons.arrowDownShortWide,
            color: AppColors.black,
            size: 35.sp,
          ),
          SizedBox(height: 12.h),
          // الجديد
          _AppointmentCard(
            date: appointmentReschedule.newAppointmentDate,
            time: appointmentReschedule.newAppointmentTime,
            style: baseStyle.copyWith(color: Colors.white),
            backgroundColor: AppColors.green,
            borderColor: AppColors.green,
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String date;
  final String time;
  final TextStyle style;
  final Color backgroundColor;
  final Color borderColor;

  const _AppointmentCard({
    required this.date,
    required this.time,
    required this.style,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconWithText(
            icon: Icons.calendar_month,
            text: date,
            textStyle: style,
          ),
          IconWithText(icon: Icons.alarm, text: time, textStyle: style),
        ],
      ),
    );
  }
}

class _DoneButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const _DoneButtonWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 45.h),
          backgroundColor: AppColors.softBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: const Text(AppStrings.done),
      ),
    );
  }
}
