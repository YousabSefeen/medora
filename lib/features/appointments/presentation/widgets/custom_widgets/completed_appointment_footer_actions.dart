import 'package:flutter/material.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/widgets/create_appointment_footer_actions.dart'
    show CreateAppointmentFooterActions;

import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/common_widgets/elevated_blue_button.dart';
import '../../../../../core/constants/themes/app_colors.dart';
import '../../../../shared/models/doctor_schedule_model.dart';
import '../create_appointment_footer_actions.dart';
import '../doctor_appointment_booking_section.dart';

class CompletedAppointmentFooterActions extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const CompletedAppointmentFooterActions({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BookAgainButton(appointment: appointment),
          _LeaveAReviewButton(appointment: appointment),
        ],
      ),
    );
  }
}

class _BookAgainButton extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const _BookAgainButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: const WidgetStatePropertyAll(AppColors.softBlue),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
      ),
      onPressed: () => _showRescheduleBottomSheet(context),
      child: const Text(AppStrings.bookAgain),
    );
  }

  /// Displays bottom sheet for rescheduling appointment
  void _showRescheduleBottomSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,

        appBarBackgroundColor: AppColors.softBlue,
        appBarTitle: AppStrings.bookAgain,
        appBarTitleColor: AppColors.white,
        body: _buildRescheduleContent(),
      );

  /// Builds the content of reschedule bottom sheet
  Widget _buildRescheduleContent() => Padding(
    padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
    child: Column(
      spacing: 30,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorBookingSection(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CreateAppointmentFooterActions(
            doctor: appointment.doctorEntity,
          ),
        ),
      ],
    ),
  );

  /// Builds doctor booking section widget
  Widget _buildDoctorBookingSection() => DoctorAppointmentBookingSection(
    doctorSchedule: DoctorScheduleModel(
      doctorId: appointment.doctorId,
      doctorAvailability: appointment.doctorEntity.doctorAvailability,
    ),
  );
}

class _LeaveAReviewButton extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const _LeaveAReviewButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedBlueButton(text: AppStrings.leaveAReview, onPressed: () {});
  }
}
