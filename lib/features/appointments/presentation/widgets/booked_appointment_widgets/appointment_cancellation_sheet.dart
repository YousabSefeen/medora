import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../../core/animations/custom_modal_type_bottom_sheet.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../../../shared/presentation/widgets/secondary_button.dart';

abstract class AppointmentCancellationSheet {
  static void show({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => CustomModalTypeBottomSheet(),
      barrierDismissible: true,
      onModalDismissedWithBarrierTap: () => context.pop(),
      pageListBuilder: (modalContext) => [
        WoltModalSheetPage(
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: true,
          topBar: _buildHeader(),
          child: _CancellationContent(
            onConfirm: () {
              modalContext.pop();
              onConfirm();
            },
            onCancel: () => modalContext.pop(),
          ),
        ),
      ],
    );
  }

  static Widget _buildHeader() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Text(
        AppStrings.cancelAppointment,
        style: TextStyle(
          color: Colors.red.shade600,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CancellationContent extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _CancellationContent({required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.cancelAppointmentConfirmation,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            AppStrings.partialRefundPolicyNote,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black54,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Action Buttons
          Row(
            children: [
              const SecondaryButton(),
              SizedBox(width: 16.w),
              PrimaryButton(text: AppStrings.yesContinue, onPressed: onConfirm),
            ],
          ),
        ],
      ),
    );
  }
}
