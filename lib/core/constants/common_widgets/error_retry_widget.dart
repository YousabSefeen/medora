import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';

class ErrorRetryWidget extends StatelessWidget {
  final bool? isSliverWidget;
  final String errorMessage;
  final String? retryButtonText;

  final VoidCallback onRetry;

  const ErrorRetryWidget({
    super.key,
    this.isSliverWidget = true,
    required this.errorMessage,
    this.retryButtonText = AppStrings.tryAgainNormal,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return isSliverWidget == true
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: _buildErrorContent(context),
          )
        : Center(child: _buildErrorContent(context));
  }

  Padding _buildErrorContent(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [_buildErrorMessageRow(context), _buildRetryButton(context)],
    ),
  );

  Row _buildErrorMessageRow(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [_buildErrorIcon(), _buildErrorMessageText(context)],
  );

  FaIcon _buildErrorIcon() =>
      const FaIcon(FontAwesomeIcons.xmark, size: 30, color: AppColors.red);

  Expanded _buildErrorMessageText(BuildContext context) => Expanded(
    child: Text(
      errorMessage,
      style: _errorMessageTextStyle(context),
      textAlign: TextAlign.center,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
  );

  TextStyle _errorMessageTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.hintFieldStyle.copyWith(fontSize: 14.sp);

  SizedBox _buildRetryButton(BuildContext context) => SizedBox(
    width: MediaQuery.sizeOf(context).width * 0.5,
    height: 40,
    child: ElevatedButton.icon(
      style: _retryButtonStyle(),

      icon: _buildRetryIcon(),
      label: _buildRetryButtonText(),
      onPressed: onRetry,
    ),
  );

  ButtonStyle _retryButtonStyle() =>
      const ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.red));

  Icon _buildRetryIcon() => const Icon(Icons.refresh, color: Colors.white);

  Text _buildRetryButtonText() => Text(retryButtonText!);
}
