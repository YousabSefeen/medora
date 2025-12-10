import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/presentation/widgets/icon_with_text.dart'
    show IconWithText;
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../features/appointments/data/models/appointment_reschedule.dart';
import '../../../generated/assets.dart';
import '../../animations/custom_modal_type_dialog.dart';
import '../app_routes/app_router.dart';
import '../app_strings/app_strings.dart';
import '../themes/app_colors.dart';

class AppointmentRescheduledDialog {
  static void show({
    required BuildContext context,
    required AppointmentRescheduleData appointmentReschedule,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => MyCustomModalTypeDialog(),
      barrierDismissible: true,
      pageListBuilder: (_) => [
        _buildSuccessModalPage(context, appointmentReschedule),
      ],
      onModalDismissedWithBarrierTap: () => Navigator.of(context).pop(),
    );
  }

  static WoltModalSheetPage _buildSuccessModalPage(
    BuildContext context,
    AppointmentRescheduleData appointmentReschedule,
  ) {
    return WoltModalSheetPage(
      backgroundColor: Colors.white,
      hasSabGradient: false,
      topBarTitle: const SizedBox.shrink(),
      topBar: _buildSuccessHeader(context),
      navBarHeight: 170.h,
      child: _buildAppointmentComparison(context, appointmentReschedule),
      stickyActionBar: _buildDoneButton(),
      isTopBarLayerAlwaysVisible: true,
    );
  }

  static Widget _buildSuccessHeader(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Column(
        children: [_buildSuccessAnimation(), _buildSuccessTitle(context)],
      ),
    );
  }

  static Widget _buildSuccessAnimation() {
    return Material(
      color: Colors.white,
      child: Lottie.asset(
        Assets.imagesSuccessIcon,
        fit: BoxFit.fill,
        height: 100.h,
      ),
    );
  }

  static Widget _buildSuccessTitle(BuildContext context) {
    return Text(
      AppStrings.yourAppointment,
      style: TextStyle(
        fontSize: 20.sp,
        color: AppColors.darkBlue,
        height: 1.5,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Widget _buildDoneButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      height: 45,
      width: double.infinity,
      child: Builder(
        builder: (innerContext) {
          return ElevatedButton(
            onPressed: () => AppRouter.pop(innerContext),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.softBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(AppStrings.done),
          );
        },
      ),
    );
  }

  static Widget _buildAppointmentComparison(
    BuildContext context,
    AppointmentRescheduleData appointmentReschedule,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final oldAppointmentStyle = _getOldAppointmentStyle(textTheme);
    final newAppointmentStyle = _getNewAppointmentStyle(textTheme);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20, bottom: 100, left: 10, right: 10),
      child: Column(
        children: [
          _buildAppointmentCard(
            date: appointmentReschedule.oldAppointmentDate,
            time: appointmentReschedule.oldAppointmentTime,
            style: oldAppointmentStyle,
            backgroundColor: Colors.grey.shade100,
            borderColor: Colors.black12,
          ),
          _buildArrowIcon(),
          _buildAppointmentCard(
            date: appointmentReschedule.newAppointmentDate,
            time: appointmentReschedule.newAppointmentTime,
            style: newAppointmentStyle,
            backgroundColor: AppColors.green,
            borderColor: AppColors.green,
          ),
        ],
      ),
    );
  }

  static TextStyle _getOldAppointmentStyle(TextTheme textTheme) {
    return textTheme.dateTimeBlackStyle.copyWith(
      fontSize: 15.sp,
      decoration: TextDecoration.lineThrough,
      decorationColor: Colors.black45,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 3,
    );
  }

  static TextStyle _getNewAppointmentStyle(TextTheme textTheme) {
    return textTheme.dateTimeBlackStyle.copyWith(
      color: Colors.white,
      fontSize: 15.sp,
    );
  }

  static Widget _buildArrowIcon() {
    return const FaIcon(
      FontAwesomeIcons.arrowDownShortWide,
      color: AppColors.black,
      size: 40,
    );
  }

  static Widget _buildAppointmentCard({
    required String date,
    required String time,
    required TextStyle style,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
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
