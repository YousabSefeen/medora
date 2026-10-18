import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/presentation/widgets/create_appointment_footer_actions.dart'
    show CreateAppointmentFooterActions;

import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/themes/app_colors.dart';
import '../../../../../core/services/overlay_notification_service.dart';
import '../../../../shared/models/doctor_schedule_model.dart';
import '../../controller/cubit/completed_appointments_cubit.dart';
import '../create_appointment_footer_actions.dart';
import '../doctor_appointment_booking_section.dart';

class CompletedAppointmentActions extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const CompletedAppointmentActions({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _BookAgainButton(appointment: appointment),
        _LeaveAReviewButton(appointment: appointment),
      ],
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
      // onPressed: () => _showRescheduleBottomSheet(context),
      onPressed: () {
        AppLogger.warning(
          'isReviewed: ${appointment.isReviewed}\nreviewId: ${appointment.reviewId} ',
        );
      },
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
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: const WidgetStatePropertyAll(AppColors.white),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
        foregroundColor: const WidgetStatePropertyAll(AppColors.blueAccent),
        side: const WidgetStatePropertyAll(
          BorderSide(color: Colors.blue, width: 1.2),
        ),
      ),

      onPressed: () async {
         context.push(
          AppRouterNames.reviews,
          extra: appointment,
        );
        // if (context.mounted &&
        //     callBackMsg == AppStrings.reviewSubmittedSuccessfully) {
        //   context.read<CompletedAppointmentsCubit>().refreshData();
        //   Future.delayed(const Duration(milliseconds: 400), () {
        //     if (!context.mounted) return;
        //     OverlayNotificationService.show(
        //       context: context,
        //       duration: AppDurations.seconds_4,
        //       message: AppStrings.reviewSubmittedSuccessfully,
        //       type: SnackBarType.success,
        //     );
        //   });
        // }
      },
      child: Text(
        appointment.isReviewed
            ? AppStrings.editReview
            : AppStrings.leaveAReview,
      ),
    );
  }
}
