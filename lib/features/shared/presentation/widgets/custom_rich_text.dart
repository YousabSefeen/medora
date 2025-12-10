import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;

  final String thirdText;

  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.smallOrangeMedium.copyWith(color: Colors.black);
    return Text.rich(
      TextSpan(
        text: firstText,
        style: textStyle,
        children: [
          TextSpan(
            text: secondText,
            style: textStyle.copyWith(
              color: AppColors.softBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: thirdText),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
