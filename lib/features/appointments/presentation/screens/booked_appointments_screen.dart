import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/appointments/presentation/widgets/cancelled_appointments_list.dart';
import 'package:medora/features/appointments/presentation/widgets/completed_appointments_list.dart';
import 'package:medora/features/appointments/presentation/widgets/upcoming_appointments_list.dart';

import '../../../shared/presentation/widgets/custom_app_bar.dart';

class BookedAppointmentsScreen extends StatelessWidget {
  const BookedAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> appointmentCategories = const [
      UpcomingAppointmentsList(),
      CompletedAppointmentsList(),
      CancelledAppointmentsList(),
    ];

    return DefaultTabController(
      length: appointmentCategories.length,
      child: Column(
        children: [
          const CustomAppBar(title: AppStrings.myAppointments),
          customTabBar(context),
          Expanded(child: TabBarView(children: appointmentCategories)),
        ],
      ),
    );
  }

  Widget customTabBar(BuildContext context) => Container(
    height: context.screenHeight * 0.055,
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: ShapeDecoration(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: const BorderSide(color: Colors.black38),
      ),
    ),
    child: TabBar(
      isScrollable: true,
      tabs: AppStrings.appointmentsListTitles
          .map((title) => Tab(text: title))
          .toList(),
    ),
  );
}
