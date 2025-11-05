import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class ErrorRetryWidget extends StatelessWidget {
  final String errorMessage;
  final String? retryButtonText;

  final VoidCallback onRetry;

  const ErrorRetryWidget({
    super.key,
    required this.errorMessage,
    this.retryButtonText,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,

      child: _buildErrorContent(context),
    );
  }

  Padding _buildErrorContent(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [_buildErrorMessageRow(), _buildRetryButton(context)],
    ),
  );

  Row _buildErrorMessageRow() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [_buildErrorIcon(), _buildErrorMessageText()],
  );

  FaIcon _buildErrorIcon() =>
      const FaIcon(FontAwesomeIcons.xmark, size: 30, color: AppColors.red);

  Expanded _buildErrorMessageText() => Expanded(
    child: Text(
      errorMessage,
      style: _errorMessageTextStyle(),
      textAlign: TextAlign.center,
    ),
  );

  TextStyle _errorMessageTextStyle() => const TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

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

  Text _buildRetryButtonText() =>
      Text(retryButtonText ?? AppStrings.tryAgainNormal);
}
