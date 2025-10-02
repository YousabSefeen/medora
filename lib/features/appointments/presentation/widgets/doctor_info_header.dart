import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../doctor_profile/data/models/doctor_model.dart';

class DoctorInfoHeader extends StatelessWidget {
  final DoctorModel doctorInfo;

  const DoctorInfoHeader({super.key, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customRichText(
          context: context,
          title: 'Bio: ',
          info: doctorInfo.bio,
        ),
        _customRichText(
          context: context,
          title: 'Location: ',
          info: doctorInfo.location,

        ),
        _customRichText(
          context: context,
          title: 'Working Days: ',


          info:getWorkingDays(),
        ),
      ],
    );
  }
   getWorkingDays()=> doctorInfo.doctorAvailability.workingDays.toString().replaceAll('[', '').replaceAll(']', '');
  RichText _customRichText({
    required BuildContext context,
    required String title,
    required String info,

  }) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: title, style: textTheme.mediumBlueBold  ),
          TextSpan(text: info, style: textTheme.smallGreyMedium),
        ],
      ),
    );
  }
}
