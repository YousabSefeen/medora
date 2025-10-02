import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_alerts/widgets/try_again_button.dart' show TryAgainButton;

import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../generated/assets.dart';
import '../../animations/custom_modal_type_dialog.dart';
import '../app_strings/app_strings.dart';
import '../themes/app_colors.dart';

class NoInternetDialog {
  static void showErrorModal({
    required BuildContext context,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => MyCustomModalTypeDialog(),
      barrierDismissible: true,
      pageListBuilder: (_) => [
        WoltModalSheetPage(
          backgroundColor: Colors.white,
          hasSabGradient: false,
          topBarTitle: const SizedBox.shrink(),
          topBar: _buildTopBar(context),
          navBarHeight: 150,
          child: _buildErrorBody(context),
          stickyActionBar: const TryAgainButton(backgroundColor: AppColors.black),
          isTopBarLayerAlwaysVisible: true,
        )
      ],
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  static Container _buildTopBar(BuildContext context) => Container(
        alignment: Alignment.center,
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          image: const DecorationImage(
            image: AssetImage(
              Assets.imagesNoInternet,
            ),
            fit: BoxFit.scaleDown,
          ),
        ),
      );

  static Container _buildErrorBody(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.only(top: 20, bottom: 100, left: 10, right: 10),
      child: Text(
        AppStrings.noInternetConnectionErrorMsg,
        style: TextStyle(
          fontSize: 14.sp,
          letterSpacing: 0.5,
          height: 1.5,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
