import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/presentation/widgets/cancelled_appointments_list.dart'
    show CancelledAppointmentsList;
import 'package:medora/features/appointments/presentation/widgets/completed_appointments_list.dart'
    show CompletedAppointmentsList;
import 'package:medora/features/appointments/presentation/widgets/upcoming_appointments_list.dart'
    show UpcomingAppointmentsList;

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
          customTabBar(context),
          Expanded(child: TabBarView(children: appointmentCategories)),
        ],
      ),
    );
  }

  Widget customTabBar(BuildContext context) {
    Size deviceSize = MediaQuery.sizeOf(context);

    return Container(
      height: deviceSize.height * 0.055,
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
}
