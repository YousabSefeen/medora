import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/lottie_string_asset_ext.dart'
    show LottieStringAssetExtension;
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/shared/presentation/widgets/custom_rich_text.dart'
    show CustomRichText;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/enum/appointment_availability_status.dart';
import '../../../../generated/assets.dart';

class DoctorNotAvailableMessage extends StatelessWidget {
  final AppointmentAvailabilityStatus appointmentAvailabilityStatus;

  const DoctorNotAvailableMessage({
    super.key,
    required this.appointmentAvailabilityStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: context.screenHeight * 0.2,
        width: context.screenWidth * 0.9,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [_buildLottieAnimation(), _buildRichTextMessage(context)],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation() {
    return Expanded(
      child: Container(
        child: Assets.lottie.xMarkerLottie.lottie(fit: BoxFit.fill),
      ),
    );
  }

  Widget _buildRichTextMessage(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.smallOrangeMedium.copyWith(color: Colors.black);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child:
            appointmentAvailabilityStatus ==
                AppointmentAvailabilityStatus.pastDate
            ? Text(
                AppStrings.pastDateBookingError,
                style: textStyle,
                textAlign: TextAlign.center,
              )
            : CustomRichText(
                firstText: AppStrings.doctorNotAvailableMessage[0],
                secondText: AppStrings.doctorNotAvailableMessage[1],
                thirdText: AppStrings.doctorNotAvailableMessage[2],
              ),
      ),
    );
  }
}
