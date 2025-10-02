import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/common_widgets/elevated_blue_button.dart' show ElevatedBlueButton;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../animations/custom_modal_type_dialog.dart';
import '../../app_strings/app_strings.dart';
import '../../themes/app_colors.dart';

class AppointmentSuccessDialog {
  static const double _modalWidthRatio = 0.7;
  static const double _successIconSize = 30.0;
  static const double _titleFontSize = 25.0;

  static const double _buttonHeight = 45.0;
  static const Duration _animationPauseDuration = Duration(milliseconds: 500);
  static const int _animationRepeatCount = 20;

  static void show({
    required BuildContext context,
    required VoidCallback onViewAppointmentPressed,
    required VoidCallback onCancelPressed,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => MyCustomModalTypeDialog(
        defaultMaxWidth: _modalWidthRatio,
      ),
      barrierDismissible: true,
      pageListBuilder: (_) => [
        _buildSuccessModalPage(
          context,
          onViewAppointmentPressed,
          onCancelPressed,
        ),
      ],
      onModalDismissedWithBarrierTap: () => Navigator.of(context).pop(),
    );
  }

  static WoltModalSheetPage _buildSuccessModalPage(
    BuildContext context,
    VoidCallback onViewAppointmentPressed,
    VoidCallback onCancelPressed,
  ) {
    return WoltModalSheetPage(
      backgroundColor: AppColors.white,
      hasSabGradient: false,
      topBarTitle: const SizedBox.shrink(),
      topBar: _buildSuccessHeader(context),
      navBarHeight: 140.h,
      child: _buildDialogContent(
        context,
        onViewAppointmentPressed,
        onCancelPressed,
      ),
      isTopBarLayerAlwaysVisible: true,
    );
  }

  static Widget _buildSuccessHeader(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: AppColors.white)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSuccessIcon(),
          SizedBox(height: 15.h),
          _buildAnimatedSuccessTitle(context),
        ],
      ),
    );
  }

  static Widget _buildSuccessIcon() {
    return CircleAvatar(
      radius: _successIconSize.sp,
      backgroundColor: AppColors.softBlue,
      child: FaIcon(
        FontAwesomeIcons.calendarCheck,
        size: _successIconSize.sp,
        color: AppColors.white,
      ),
    );
  }

  static Widget _buildAnimatedSuccessTitle(BuildContext context) {
    const List<Color> colorizeColors = [
      Colors.blue,
      Colors.white,
      Colors.red,
      Colors.amber,
    ];

    final colorizeTextStyle = GoogleFonts.raleway(
      textStyle: const TextStyle(
        fontSize: _titleFontSize,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );

    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          AppStrings.appointmentSuccessDialogTitle,
          colors: colorizeColors,
          textStyle: colorizeTextStyle,
        ),
      ],
      pause: _animationPauseDuration,
      repeatForever: true,
      totalRepeatCount: _animationRepeatCount,
    );
  }

  static Widget _buildDialogContent(
    BuildContext context,
    VoidCallback onViewAppointmentPressed,
    VoidCallback onCancelPressed,
  ) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          _buildSuccessMessage(context),
          _buildActionButtons(
            context,
            onViewAppointmentPressed,
            onCancelPressed,
          ),
        ],
      ),
    );
  }

  static Widget _buildSuccessMessage(BuildContext context) {
    return Text(
      AppStrings.appointmentSuccessDialogMessage,
      style: Theme.of(context).textTheme.smallOrangeMedium,
      textAlign: TextAlign.center,
    );
  }

  static Widget _buildActionButtons(
    BuildContext context,
    VoidCallback onViewAppointmentPressed,
    VoidCallback onCancelPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 15,
        children: [
          _buildViewAppointmentButton(context, onViewAppointmentPressed),
          _buildCancelButton(onCancelPressed),
        ],
      ),
    );
  }

  static Widget _buildViewAppointmentButton(
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: _buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
            ),
        child: const Text(AppStrings.viewAppointment),
      ),
    );
  }

  static Widget _buildCancelButton(VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: _buttonHeight,
      child: ElevatedBlueButton(
        text: AppStrings.cancel,
        onPressed: onPressed,
      ),
    );
  }
}
