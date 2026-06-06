import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart'
    show AppTextStyles;
import 'package:medora/core/extensions/lottie_string_asset_ext.dart'
    show LottieStringAssetExtension;
import 'package:medora/core/extensions/media_query_extension.dart'
    show MediaQueryExtension;
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:medora/generated/assets.dart' show Assets;

class EmptySearchListResult extends StatelessWidget {
  const EmptySearchListResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20.h,
      children: [
        Assets.lottie.noFavoriteDoctors.lottie(
          fit: BoxFit.cover,
          height: context.screenHeight * 0.2,
        ),
        Text(
          AppStrings.noMatchingDoctorsFoundMessage,
          style: context.textTheme.bodyMediumEx,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
