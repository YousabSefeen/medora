import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/animations/custom_modal_type_left_sheet.dart' show CustomModalTypeLeftSheet;
import 'package:medora/core/constants/app_alerts/no_internet_dialog.dart'
    show NoInternetDialog;
import 'package:medora/core/constants/app_alerts/widgets/appointment_success_dialog.dart'
    show AppointmentSuccessDialog;
import 'package:medora/core/constants/app_alerts/widgets/loading_dialog_body.dart'
    show LoadingDialogBody;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../features/appointments/data/models/appointment_reschedule.dart';
import '../../animations/custom_modal_type_bottom_sheet.dart';
import 'appointment_canceled_success_dialog.dart';
import 'appointment_cancellation_sheet.dart';
import 'appointment_rescheduled_dialog.dart';
import 'error_dialogs.dart';
import 'widgets/app_alert_widgets.dart';

class AppAlerts {
  static void showErrorSnackBar(BuildContext context, String errorMessage) {
    //  ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(AppAlertWidgets.errorSnackBar(errorMessage));
  }

  static showTopSnackBarAlert({
    required BuildContext context,
    IconData? icon,
    required String msg,
    required Color backgroundColor,
  }) {
    showTopSnackBar(
      padding: EdgeInsets.zero,
      displayDuration: const Duration(seconds: 2),
      Overlay.of(context),
      CustomSnackBar.show(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        message: msg,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.2,
        ),
        icon: icon == null
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(right: 5),
                child: FaIcon(icon, color: Colors.white, size: 20.sp),
              ),
      ),
    );
  }

  static void showRegisterErrorSnackBar({
    required BuildContext context,
    required Widget content,
    required String errorMessage,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      AppAlertWidgets.registerSnackBar(
        content: content,
        errorMessage: errorMessage,
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

  static void showAppointmentSuccessDialog({
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
        Navigator.of(context).pop();
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
          onPressed: Navigator.of(modalSheetContext).pop,
        ),

        // إذا كنت ترغب في إضافة شريط التمرير هذا الجسم باستخدام مكون واجهة المستخدم ليتمكن من المرور في ورقة مشروطة ، يجب عليك ضبط مكون واجهة المستخدم بواسطة ال Scrollbar Widget
        // ليكون بهذا الشكل
        //   child: Scrollbar(child: body),
        child: shouldShowScrollbar! ? Scrollbar(child: body) : body,
      ),
    ],
    onModalDismissedWithBarrierTap: () {
      debugPrint('Closed modal sheet with barrier tap');
      Navigator.of(context).pop();
    },
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
    modalTypeBuilder: (_) => CustomModalTypeLeftSheet(),

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

        // إذا كنت ترغب في إضافة شريط التمرير هذا الجسم باستخدام مكون واجهة المستخدم ليتمكن من المرور في ورقة مشروطة ، يجب عليك ضبط مكون واجهة المستخدم بواسطة ال Scrollbar Widget
        // ليكون بهذا الشكل
        //   child: Scrollbar(child: body),
        child:  body,
      ),
    ],
    onModalDismissedWithBarrierTap:onCancelPressed,
  );
  //*********************
  static void showSpecialitiesBottomSheet({
    required BuildContext context,

    required Widget trailingNavBarWidget,
    required Widget body,
    Widget? stickyActionBar,
  }) => WoltModalSheet.show(
    context: context,
    modalTypeBuilder: (_) => CustomModalTypeBottomSheet(),
    barrierDismissible: true,
    pageListBuilder: (modalSheetContext) => [
      WoltModalSheetPage(
        hasSabGradient: false,
        topBar: const SizedBox(),

        stickyActionBar: stickyActionBar,
        isTopBarLayerAlwaysVisible: true,
        trailingNavBarWidget: trailingNavBarWidget,
        child: body,
      ),
    ],
    onModalDismissedWithBarrierTap: () {
      debugPrint('Closed modal sheet with barrier tap');
      Navigator.of(context).pop();
    },
  );

  //*************
  static void showNoInternetDialog(BuildContext context) =>
      NoInternetDialog.showErrorModal(context: context);

  static void showErrorDialog(BuildContext context, String errorMessage) =>
      ErrorDialogs.showErrorDialog(
        context: context,
        errorMessage: errorMessage,
      );

  static void showCustomErrorDialog(BuildContext context, String errorMessage) {
    if (errorMessage == AppStrings.noInternetConnectionErrorMsg) {
      showNoInternetDialog(context);
    } else {
      showErrorDialog(context, errorMessage);
    }
  }

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
    required AppointmentRescheduleData appointmentReschedule,
  }) => AppointmentRescheduledDialog.show(
    context: context,
    appointmentReschedule: appointmentReschedule,
  );

  static void showAppointmentSuccessDialogX({
    required BuildContext context,
    required VoidCallback onViewAppointmentPressed,
    required VoidCallback onCancelPressed,
  }) => AppointmentSuccessDialog.show(
    context: context,
    onViewAppointmentPressed: onViewAppointmentPressed,
    onCancelPressed: onCancelPressed,
  );

  static void showCanceledSuccessDialog({required BuildContext context}) =>
      AppointmentCanceledSuccessDialog.show(context: context);

  ///New In Payments**********************************************************************************

  // static customErrorSnackBar({
  //   required BuildContext context,
  //   required String msg,
  // }) {
  //   showTopSnackBar(
  //     displayDuration: const Duration(seconds: 2),
  //     Overlay.of(context),
  //     CustomSnackBar.error(
  //       icon: const SizedBox(),
  //       textStyle: TextStyle(
  //         fontSize: 18.sp,
  //         color: Colors.white,
  //         fontWeight: FontWeight.w500,
  //       ),
  //       message: msg,
  //     ),
  //   );
  // }

  static customPaymentCanceledDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Canceled'),
          content: const Text('The payment process was canceled by the user.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void customToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red.shade500,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
