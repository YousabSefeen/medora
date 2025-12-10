import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
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
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: MediaQuery.sizeOf(context).width * 0.8,
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
        child: Lottie.asset(Assets.imagesXMarker, fit: BoxFit.fill),
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
