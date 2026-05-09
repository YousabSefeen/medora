import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../app_strings/app_strings.dart';
import '../themes/app_colors.dart';

class GeminiErrorDialog {
  static Future<void> showDialog({
    required BuildContext context,
    required String errorMessage,
    required bool showCloseButtonOnly ,
    void Function()? onRetryNow,
  }) => WoltModalSheet.show(
    context: context,
    enableDrag: false,
    showDragHandle: false,
    barrierDismissible: true,

    pageListBuilder: (_) => [
      WoltModalSheetPage(
        backgroundColor: Colors.white,
        hasSabGradient: false,
        topBarTitle: const SizedBox.shrink(),
        topBar: _buildTopBar(context),
        navBarHeight: 60,

        child: _buildErrorBody(context, errorMessage),
        stickyActionBar: _buildActionsButtons(
          context: context,
          onRetryNow: onRetryNow,
          showCloseButtonOnly: showCloseButtonOnly,
        ),
        isTopBarLayerAlwaysVisible: true,
      ),
    ],
    onModalDismissedWithBarrierTap: () => _navigatorPop(context),
  );

  static Widget _buildTopBar(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    alignment: Alignment.center,
    color: AppColors.red,
    child: Row(
      spacing: 5,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 13.r,
          child: FaIcon(
            FontAwesomeIcons.xmark,
            size: 20.sp,
            color: AppColors.red,
          ),
        ),

        Text(
          AppStrings.somethingWentWrong,
          style: context.textTheme.buttonStyle.copyWith(
            fontSize: 18.sp,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
        const SizedBox(height: 5),
      ],
    ),
  );

  static Widget _buildErrorBody(BuildContext context, String errorMessage) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 100, left: 8, right: 8),
      //constraints: const BoxConstraints(minHeight: 70),
      child: RichText(
        text: TextSpan(
          text: AppStrings.errorMessageLabel,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: errorMessage == ''
                  ? AppStrings.unexpectedError
                  : errorMessage,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildActionsButtons({
    required BuildContext context,
    required bool showCloseButtonOnly,
    void Function()? onRetryNow,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0,bottom: 10),
      child: showCloseButtonOnly
          ? _buildCloseButton(context)
          : _buildActions(context, onRetryNow),
    );
  }

  static Row _buildActions(BuildContext context, void Function()? onRetryNow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade50,
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.black26),
          ),
          onPressed: () => _navigatorPop(context),
          child: const Text(AppStrings.cancel),
        ),
        const SizedBox(width: 15),
        ElevatedButton(
          style: TextButton.styleFrom(backgroundColor: Colors.green),
          onPressed: onRetryNow,
          child: const Text(AppStrings.retryNow),
        ),
      ],
    );
  }

  static void _navigatorPop(BuildContext context) => AppRouter.pop(context);

  static Widget _buildCloseButton(BuildContext context) => Align(
    alignment: Alignment.centerRight,
    child: ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: () => _navigatorPop(context),
      child: const Text(AppStrings.close),
    ),
  );
}
