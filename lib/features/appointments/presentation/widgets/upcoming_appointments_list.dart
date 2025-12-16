import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;

import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';
import '../screens/appointment_details_screen.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsList extends StatelessWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingAppointments = context
        .read<AppointmentCubit>()
        .upcomingAppointments;

    return upcomingAppointments!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyUpcomingAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: upcomingAppointments.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // //AppAlerts.showNoInternetDialog(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AppointmentDetailsScreen(
                      doctorModel: upcomingAppointments[index].doctorEntity,
                      appointmentDate:
                          upcomingAppointments[index].appointmentDate,
                      appointmentTime:
                          upcomingAppointments[index].appointmentTime,
                      patientName: upcomingAppointments[index].patientName,
                      patientGender: upcomingAppointments[index].patientGender,
                      patientAge: upcomingAppointments[index].patientAge,
                      patientProblem:
                          upcomingAppointments[index].patientProblem,
                    ),
                  ),
                );
              },

              child: AppointmentCard(
                appointmentStatus: AppointmentStatus.confirmed,
                appointment: upcomingAppointments[index],
              ),
            ),
          );
  }
}
