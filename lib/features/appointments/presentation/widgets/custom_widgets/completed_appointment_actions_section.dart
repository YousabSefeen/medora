import 'package:flutter/material.dart';
import 'package:medora/features/appointments/data/models/picked_doctor_info_model.dart'
    show PickedDoctorInfoModel;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/common_widgets/elevated_blue_button.dart';
import '../../../../../core/constants/themes/app_colors.dart';
import '../../../../shared/models/doctor_schedule_model.dart';
import '../../../data/models/client_appointments_model.dart';
import '../book_appointment_button.dart';
import '../doctor_appointment_booking_section.dart';

class CompletedAppointmentActionsSection extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const CompletedAppointmentActionsSection({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final DoctorModel c = appointment.doctorModel;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BookAgainButton(appointment: appointment),
          LeaveAReviewButton(appointment: appointment),
        ],
      ),
    );
  }
}

class BookAgainButton extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const BookAgainButton({super.key, required this.appointment});

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
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
    child: Column(
      spacing: 30,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorBookingSection(),
        BookAppointmentButton(
          pickedDoctorInfoModel: PickedDoctorInfoModel(
            doctorId: appointment.doctorId,
            doctorModel: appointment.doctorModel,
          ),
        ),
      ],
    ),
  );

  /// Builds doctor booking section widget
  Widget _buildDoctorBookingSection() => DoctorAppointmentBookingSection(
    doctorSchedule: DoctorScheduleModel(
      doctorId: appointment.doctorId,
      doctorAvailability: appointment.doctorModel.doctorAvailability,
    ),
  );
}

class LeaveAReviewButton extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const LeaveAReviewButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedBlueButton(text: AppStrings.leaveAReview, onPressed: () {});
  }
}
