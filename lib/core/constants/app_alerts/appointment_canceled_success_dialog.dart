import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../generated/assets.dart';
import '../../animations/custom_modal_type_dialog.dart';
import '../app_strings/app_strings.dart';
import '../themes/app_colors.dart';

class AppointmentCanceledSuccessDialog {
  static void show({required BuildContext context}) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => MyCustomModalTypeDialog(),
      barrierDismissible: true,
      pageListBuilder: (_) => [_buildSuccessModalPage(context)],
      onModalDismissedWithBarrierTap: () => Navigator.of(context).pop(),
    );
  }

  static WoltModalSheetPage _buildSuccessModalPage(BuildContext context) {
    return WoltModalSheetPage(
      backgroundColor: Colors.white,
      hasSabGradient: false,
      topBarTitle: const SizedBox.shrink(),
      topBar: _buildSuccessHeader(context),
      navBarHeight: 150.h,
      child: _buildAppointmentComparison(context),
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
    return FittedBox(
      child: Text(
        AppStrings.cancelAppointmentSuccess,
        style: TextStyle(
          fontSize: 20.sp,
          color: AppColors.darkBlue,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Widget _buildAppointmentComparison(BuildContext context) {
    return Container(
      color: AppColors.softBlue,
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      child: Column(
        spacing: 20,
        children: [
          Text(
            AppStrings.appointmentCancelledSuccessfully,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () => AppRouter.pop(context),
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              foregroundColor: WidgetStatePropertyAll(Colors.black),
            ),
            child: const Text(AppStrings.done),
          ),
        ],
      ),
    );
  }
}
