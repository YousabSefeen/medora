import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  final String label;
  final String value;

  const AppointmentDetailsWidget(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final textTheme = Theme.of(context).textTheme;
    final latoSemiBoldDark = textTheme.latoSemiBoldDark;
    final caladeaMediumLight = textTheme.caladeaMediumLight;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: deviceWidth * 0.32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: latoSemiBoldDark,
                ),
                Text(
                  ':   ',
                  style: latoSemiBoldDark.copyWith(
                    fontWeight: FontWeight.w900,
                    shadows: [],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: caladeaMediumLight.copyWith(),
            ),
          ),
          // Expanded(
          //   child: RichText(
          //
          //     text: TextSpan(
          //       children: [
          //         TextSpan(
          //           text: ':    ',
          //           style: latoSemiBoldDark.copyWith(
          //             fontWeight: FontWeight.w900,
          //             shadows: [],
          //           ),
          //         ),
          //         TextSpan(
          //           text: 'value Payment Success Static Header',
          //           style: caladeaMediumLight.copyWith(),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
