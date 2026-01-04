import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/fetch_client_appointments_cubit.dart' show FetchClientAppointmentsCubit;

import '../../../../core/constants/common_widgets/content_unavailable_widget.dart';
import '../../../../core/enum/appointment_status.dart';
import '../screens/appointment_details_screen.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsList extends StatelessWidget {
  final   List<ClientAppointmentsEntity>? upcomingAppointmentsList;
  const UpcomingAppointmentsList({super.key,required this.upcomingAppointmentsList});

  @override
  Widget build(BuildContext context) {


    return upcomingAppointmentsList!.isEmpty
        ? const ContentUnavailableWidget(
            description: AppStrings.emptyUpcomingAppointmentsMessage,
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            itemCount: upcomingAppointmentsList!.length,
            itemBuilder: (context, index) {
              final  List<ClientAppointmentsEntity>   upcomingAppointments=upcomingAppointmentsList!;
              return GestureDetector(
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
            );
            },
          );
  }
}
