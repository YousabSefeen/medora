import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../animations/custom_modal_type_bottom_sheet.dart';

class AppointmentCancellationSheet {
  static void showCancelAppointmentSheet({
    required BuildContext context,
   required VoidCallback  onCancelPressed,
   required VoidCallback  onConfirmPressed,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => CustomModalTypeBottomSheet(),
      barrierDismissible: true,
      pageListBuilder: (modalSheetContext) => [
        _buildConfirmationPage(context, onCancelPressed, onConfirmPressed),
      ],
      onModalDismissedWithBarrierTap: () => _handleBarrierTap(context),
    );
  }

  static WoltModalSheetPage _buildConfirmationPage(
      BuildContext context,
      VoidCallback? onCancelPressed,
      VoidCallback? onConfirmPressed,
      ) {
    return WoltModalSheetPage(
      hasSabGradient: false,
      topBar: _buildSheetHeader(context),
      isTopBarLayerAlwaysVisible: true,
      child: _buildConfirmationContent(context, onCancelPressed, onConfirmPressed),
    );
  }

  static Widget _buildSheetHeader(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Text(
        AppStrings.cancelAppointment,
        style: TextStyle(
          color: Colors.red.shade600,
          fontSize: 16.sp,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget _buildConfirmationContent(
      BuildContext context,
      VoidCallback? onCancelPressed,
      VoidCallback? onConfirmPressed,
      ) {
    return Container(
      width: 200,
      color: Colors.white,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03,
        horizontal: MediaQuery.sizeOf(context).width * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildConfirmationMessage(),
          SizedBox(height: 15.h),
          _buildRefundPolicyNote(),
          SizedBox(height: 15.h),
          _buildActionButtons(context, onCancelPressed, onConfirmPressed),
        ],
      ),
    );
  }

  static Widget _buildConfirmationMessage() {
    return Text(
      AppStrings.cancelAppointmentConfirmation,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  static Widget _buildRefundPolicyNote() {
    return Text(
      AppStrings.partialRefundPolicyNote,
      style: GoogleFonts.roboto(
        color: Colors.black54,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  static Widget _buildActionButtons(
      BuildContext context,
      VoidCallback? onCancelPressed,
      VoidCallback? onConfirmPressed,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCancelButton(context, onCancelPressed),
        SizedBox(width: 30.w),
        _buildConfirmButton(context, onConfirmPressed),
      ],
    );
  }

  static Widget _buildCancelButton(BuildContext context, VoidCallback? onPressed) {
    return Expanded(
      child: SizedBox(
        height: 50.h,
        child: ElevatedButton(
          style: _cancelButtonStyle(),
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
          child: const Text(AppStrings.cancel),
        ),
      ),
    );
  }

  static Widget _buildConfirmButton(BuildContext context, VoidCallback? onPressed) {
    return Expanded(
      child: SizedBox(
        height: 50.h,
        child: ElevatedButton(
          style: _confirmButtonStyle(),
          onPressed: onPressed,
          child: const Text(AppStrings.yesContinue),
        ),
      ),
    );
  }

  static ButtonStyle _cancelButtonStyle() {
    return ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(Colors.white),
      foregroundColor: const WidgetStatePropertyAll(AppColors.darkBlue),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.darkBlue),
        ),
      ),
    );
  }

  static ButtonStyle _confirmButtonStyle() {
    return ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(AppColors.darkBlue),
      foregroundColor: WidgetStatePropertyAll(AppColors.white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.darkBlue),
        ),
      ),
    );
  }

  static void _handleBarrierTap(BuildContext context) {
    debugPrint('Cancellation sheet dismissed by tapping barrier');
    Navigator.of(context).pop();
  }
}