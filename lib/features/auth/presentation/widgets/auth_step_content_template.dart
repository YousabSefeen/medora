import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/generated/assets.dart';

class AuthStepContentTemplate extends StatelessWidget {
  final LottieGenImage lottieGenImage;
  final FaIconData mainIcon;
  final FaIconData badgeIcon;
  final String stepTitle;
  final String stepSubtitle;
  final CrossAxisAlignment crossAxisAlignment;

  const AuthStepContentTemplate({
    super.key,

    this.mainIcon = FontAwesomeIcons.lock,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.badgeIcon,
    required this.stepTitle,
    required this.stepSubtitle,
    required this.lottieGenImage,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: crossAxisAlignment,
      children: [
        //SizedBox(height: context.screenHeight * 0.05),

        lottieGenImage.lottie(fit: BoxFit.cover, height: 180, width: 180),

        SizedBox(height: context.screenHeight * 0.05),

        Text(
          stepTitle,
          style: textTheme.largeWhiteBold.copyWith(fontSize: 22.sp),
        ),
        const SizedBox(height: 7),
        Text(
          stepSubtitle,
          style: textTheme.mediumLightGreyRegular.copyWith(
            color: textTheme.headerSubtitle.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
