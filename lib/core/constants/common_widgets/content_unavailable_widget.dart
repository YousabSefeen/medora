/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/extensions/lottie_string_asset_ext.dart'
    show LottieStringAssetExtension;
import 'package:medora/core/extensions/media_query_extension.dart';

class ContentUnavailableWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const ContentUnavailableWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.screenHeight * 0.25,
        width: context.screenWidth * 0.8,
        child: Column(
          children: [_buildLottieAnimation(), _buildMessageText(context)],
        ),
      ),
    );
  }

  Expanded _buildLottieAnimation() =>
      Expanded(child: imagePath.lottie(fit: BoxFit.cover));

  Widget _buildMessageText(BuildContext context) {
    final baseTextStyle = TextStyle(
      color: AppColors.darkBlue,
      height: 1.9,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    );

    return Column(
      children: [
        Text(title, style: baseTextStyle, textAlign: TextAlign.center),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subtitle,
            style: baseTextStyle.copyWith(
              color: AppColors.customBlueGrey,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
*/
