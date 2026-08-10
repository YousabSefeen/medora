import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/animations/custom_modal_type_left_sheet.dart'
    show CustomModalTypeLeftSheet;
import 'package:medora/core/constants/app_alerts/gemini_error_dialog.dart'
    show GeminiErrorDialog;
import 'package:medora/core/constants/app_alerts/no_internet_dialog.dart'
    show NoInternetDialog;
import 'package:medora/core/constants/app_alerts/widgets/loading_dialog_body.dart'
    show LoadingDialogBody;
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/presentation/ui_models/appointment_reschedule_ui_model.dart'
    show AppointmentRescheduleUIModel;
import 'package:medora/features/auth/presentation/widgets/auth_error_snack_bar_content.dart';
import 'package:medora/features/auth/presentation/widgets/email_already_in_use_snack_bar_content.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../animations/custom_modal_type_bottom_sheet.dart';
import 'appointment_cancellation_sheet.dart';
import 'appointment_rescheduled_dialog.dart';
import 'error_dialogs.dart';
import 'widgets/app_alert_widgets.dart';

class AppAlerts {
  static void showInternetAlert(BuildContext context, bool isConnected) {
    final message = isConnected
        ? AppStrings.internetConnected
        : AppStrings.noInternetConnection;
    final color = isConnected ? AppColors.green : AppColors.red;
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircleAvatar(
              radius: 11.r,
              backgroundColor: Colors.white,
              child: FaIcon(
                isConnected ? FontAwesomeIcons.check : FontAwesomeIcons.xmark,
                size: 12.sp,
                color: Colors.black,
              ),
            ),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.buttonStyle.copyWith(fontSize: 13.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        duration: AppDurations.seconds_3,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 10.w, right: 30.w, bottom: 5.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        backgroundColor: color,
      ),
    );
  }

  static void showAuthErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 1,
        behavior: SnackBarBehavior.floating,
        duration: AppDurations.seconds_7,
        backgroundColor: Colors.grey.shade900,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.red),
        ),
        content: AuthErrorSnackBarContent(errorMessage: errorMessage),
      ),
    );
  }

  static void showEmailAlreadyInUseSnackBar({
    required BuildContext context,

    required void Function() onSignInPressed,
    required void Function() onDismissPressed,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: AppDurations.minutes_1,

        backgroundColor: Colors.grey.shade900,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.red),
        ),
        content: EmailAlreadyInUseSnackBarContent(
          onSignInPressed: onSignInPressed,
          onDismissPressed: onDismissPressed,
        ),
      ),
    );
  }

  static void customDialog({
    required BuildContext context,
    required Widget body,
  }) => showDialog(context: context, builder: (context) => body);

  static void showLoadingDialog(BuildContext context) => showGeneralDialog(
    context: context,
    barrierLabel: 'loading',
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, _, __) => const LoadingDialogBody(),
    transitionBuilder: (context, animation1, _, child) => ScaleTransition(
      scale: CurvedAnimation(parent: animation1, curve: Curves.easeOutBack),
      child: child,
    ),
  );

  static void showCircularProgressIndicatorLoadingDialog(
    BuildContext context,
  ) => showGeneralDialog(
    context: context,
    barrierLabel: 'loading',
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 300),

    pageBuilder: (context, _, __) =>
        const Center(child: CustomCircularProgress()),
    transitionBuilder: (context, animation1, _, child) => ScaleTransition(
      scale: CurvedAnimation(parent: animation1, curve: Curves.easeOutBack),
      child: child,
    ),
  );

  static Future<void> showAppointmentSuccessDialog({
    required BuildContext context,
    required String message,
  }) => showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: message,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, _, __) {
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!context.mounted) return;
        context.pop();
      });

      return Align(
        child: Material(
          color: Colors.transparent,
          child: AppAlertWidgets.successDialogContent(message),
        ),
      );
    },
    transitionBuilder: (context, animation1, _, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: animation1, curve: Curves.easeOutBack),
        child: child,
      );
    },
  );

  static void showCustomBottomSheet({
    required BuildContext context,
    required Color appBarBackgroundColor,
    required String appBarTitle,
    required Color appBarTitleColor,
    required Widget body,
    Widget? stickyActionBar,
    bool? shouldShowScrollbar = true,
  }) => WoltModalSheet.show(
    context: context,
    modalTypeBuilder: (_) => CustomModalTypeBottomSheet(),
    pageListBuilder: (modalSheetContext) => [
      WoltModalSheetPage(
        hasSabGradient: false,
        topBar: AppAlertWidgets.customSheetTopBar(
          context: context,
          appBarBackgroundColor: appBarBackgroundColor,
          appBarTitle: appBarTitle,
          appBarTitleColor: appBarTitleColor,
        ),
        stickyActionBar: stickyActionBar,
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(20),
          icon: FaIcon(
            FontAwesomeIcons.xmark,
            color: appBarTitleColor,
            size: 25.sp,
          ),
          onPressed: () => modalSheetContext.pop(),
        ),

        child: body,
      ),
    ],
    onModalDismissedWithBarrierTap: () => context.pop(),
  );

  ////
  static void showLeftSheet({
    required BuildContext context,
    required Color appBarBackgroundColor,
    required String appBarTitle,
    required Color appBarTitleColor,
    required Widget body,
    Widget? stickyActionBar,
    required VoidCallback onCancelPressed,
  }) => WoltModalSheet.show(
    context: context,
    modalTypeBuilder: (_) => CustomModalTypeLeftSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
    ),

    pageListBuilder: (modalSheetContext) => [
      WoltModalSheetPage(
        hasSabGradient: false,
        topBar: AppAlertWidgets.customSheetTopBar(
          context: context,
          appBarBackgroundColor: appBarBackgroundColor,
          appBarTitle: appBarTitle,
          appBarTitleColor: appBarTitleColor,
        ),
        stickyActionBar: stickyActionBar,
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: IconButton(
          padding: const EdgeInsets.all(20),
          icon: FaIcon(
            FontAwesomeIcons.xmark,
            color: appBarTitleColor,
            size: 25.sp,
          ),
          onPressed: onCancelPressed,
        ),

        child: body,
      ),
    ],
    onModalDismissedWithBarrierTap: onCancelPressed,
  );

  static Future<void> showGeminiErrorDialog({
    required BuildContext context,
    required String errorMessage,
    bool showCloseButtonOnly = true,
    void Function()? onRetryNow,
  }) async => await GeminiErrorDialog.showDialog(
    context: context,
    errorMessage: errorMessage,
    showCloseButtonOnly: showCloseButtonOnly,
    onRetryNow: onRetryNow,
  );

  static void showCancelAppointmentBottomSheet({
    required BuildContext context,
    required VoidCallback onCancelPressed,
    required VoidCallback onConfirmPressed,
  }) => AppointmentCancellationSheet.showCancelAppointmentSheet(
    context: context,
    onCancelPressed: onCancelPressed,
    onConfirmPressed: onConfirmPressed,
  );

  static void showRescheduleSuccessDialog({
    required BuildContext context,
    required AppointmentRescheduleUIModel appointmentReschedule,
  }) => AppointmentRescheduledDialog.show(
    context: context,
    appointmentReschedule: appointmentReschedule,
  );

  static Future<void> showCustomErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async {
    if (errorMessage == AppStrings.noInternetConnectionErrorMsg) {
      await _showNoInternetDialog(context);
    } else {
      await _showErrorDialog(context, errorMessage);
    }
  }

  static Future<void> _showNoInternetDialog(BuildContext context) async =>
      await NoInternetDialog.showErrorModal(context: context);

  static Future<void> _showErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async => await ErrorDialogs.showErrorDialog(
    context: context,
    errorMessage: errorMessage,
  );
}
