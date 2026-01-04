import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart' show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/widgets/upcoming_appointments_list.dart'
    show UpcomingAppointmentsList;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../data/models/client_appointments_model.dart';
import 'cancelled_appointments_list.dart';
import 'completed_appointments_list.dart';

class BookedAppointmentsList extends StatelessWidget {

  final List<ClientAppointmentsEntity>? upcomingAppointmentsList;
  final List<ClientAppointmentsEntity>? completedAppointmentsList;
  final List<ClientAppointmentsEntity>? cancelledAppointmentsList;
  const BookedAppointmentsList({super.key, required this.upcomingAppointmentsList, required this.completedAppointmentsList, required this.cancelledAppointmentsList});

  @override
  Widget build(BuildContext context) {
    List<Widget> appointmentCategories = [
        UpcomingAppointmentsList(upcomingAppointmentsList:upcomingAppointmentsList),
        CompletedAppointmentsList(completedAppointmentsList:completedAppointmentsList),
        CancelledAppointmentsList(cancelledAppointmentsList:cancelledAppointmentsList),
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
        color: AppColors.customWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        shadows: const [
          BoxShadow(color: Colors.blue, blurRadius: 2, spreadRadius: 1),
        ],
      ),
      child: TabBar(
        isScrollable: true,
        indicator: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
        unselectedLabelColor: Colors.black,
        tabs: AppStrings.appointmentsListTitles
            .map((title) => Tab(text: title))
            .toList(),
      ),
    );
  }
}
