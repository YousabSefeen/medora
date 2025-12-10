import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/shared/models/doctor_schedule_model.dart'
    show DoctorScheduleModel;

import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../data/models/appointment_reschedule.dart';
import '../../../data/models/client_appointments_model.dart';
import '../../controller/states/appointment_action_state.dart';
import '../../controller/states/appointment_state.dart';
import '../custom_widgets/adaptive_action_button.dart';
import '../doctor_appointment_booking_section.dart';

class AppointmentRescheduleButton extends StatelessWidget {
  final ClientAppointmentsModel appointment;

  const AppointmentRescheduleButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
      ),
      onPressed: () => _showRescheduleBottomSheet(context),
      child: const Text(AppStrings.reschedule),
    );
  }

  /// Displays bottom sheet for rescheduling appointment
  void _showRescheduleBottomSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,
        appBarBackgroundColor: AppColors.softBlue,
        appBarTitle: AppStrings.editBookingAppointment,
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
        _buildRescheduleTitle(),
        _buildDoctorBookingSection(),
        _buildRescheduleConfirmationButton(),
      ],
    ),
  );

  /// Builds title widget for reschedule bottom sheet
  Widget _buildRescheduleTitle() => Text(
    'When would you like to come?',
    style: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
    textAlign: TextAlign.start,
  );

  /// Builds doctor booking section widget
  Widget _buildDoctorBookingSection() => DoctorAppointmentBookingSection(
    doctorSchedule: DoctorScheduleModel(
      doctorId: appointment.doctorId,
      doctorAvailability: appointment.doctorModel.doctorAvailability,
    ),
  );

  /// Builds confirmation button for rescheduling
  Widget _buildRescheduleConfirmationButton() => RescheduleConfirmationButton(
    doctorId: appointment.doctorId,
    appointmentId: appointment.appointmentId,
    appointmentDate: appointment.appointmentDate,
    appointmentTime: appointment.appointmentTime,
  );
}

class RescheduleConfirmationButton extends StatelessWidget {
  final String doctorId;
  final String appointmentId;
  final String appointmentDate;
  final String appointmentTime;

  const RescheduleConfirmationButton({
    super.key,
    required this.doctorId,
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AppointmentCubit,
      AppointmentState,
      AppointmentActionState
    >(
      selector: (state) => AppointmentActionState(
        selectedDate: state.selectedDateFormatted,
        selectedTimeSlot: state.selectedTimeSlot,
        actionState: state.rescheduleAppointmentState,
        actionError: state.rescheduleAppointmentError,
      ),
      builder: (context, appointmentData) {
        _handleRescheduleResponse(context, appointmentData);
        return _buildRescheduleButton(context, appointmentData);
      },
    );
  }

  /// Builds the reschedule confirmation button with appropriate state
  Widget _buildRescheduleButton(
    BuildContext context,
    AppointmentActionState appointmentData,
  ) {
    final isEnabled = appointmentData.selectedTimeSlot != '';
    final isLoading = appointmentData.actionState == LazyRequestState.loading;

    return AdaptiveActionButton(
      title: AppStrings.confirmReschedule,
      isEnabled: isEnabled,
      isLoading: isLoading,
      onPressed: () => _executeReschedule(context),
    );
  }

  /// Triggers the reschedule appointment process
  void _executeReschedule(BuildContext context) {
    print('RescheduleConfirmationButton._executeReschedule ${doctorId}');
    context.read<AppointmentCubit>().rescheduleAppointment(
      doctorId: doctorId,
      appointmentId: appointmentId,
    );
  }

  /// Handles different states of the reschedule process
  void _handleRescheduleResponse(
    BuildContext context,
    AppointmentActionState appointmentData,
  ) {
    switch (appointmentData.actionState) {
      case LazyRequestState.error:
        _showRescheduleError(context, appointmentData.actionError);
        break;
      case LazyRequestState.loaded:
        _handleSuccessfulReschedule(context, appointmentData);
        break;
      case LazyRequestState.loading:
      case LazyRequestState.lazy:
        break;
    }
  }

  /// Shows appropriate error dialog when reschedule fails
  void _showRescheduleError(BuildContext context, String errorMessage) {
    Future.microtask(() {
      if (!context.mounted) return;

      AppAlerts.showCustomErrorDialog(context, errorMessage);

      _resetRescheduleState(context);
    });
  }

  /// Handles successful reschedule completion
  void _handleSuccessfulReschedule(
    BuildContext context,
    AppointmentActionState appointmentData,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      _returnToPreviousScreen(context);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!context.mounted) return;
        AppAlerts.showRescheduleSuccessDialog(
          context: context,
          appointmentReschedule: AppointmentRescheduleData(
            oldAppointmentDate: appointmentDate,
            oldAppointmentTime: appointmentTime,
            newAppointmentDate: appointmentData.selectedDate!,
            newAppointmentTime: appointmentData.selectedTimeSlot!,
          ),
        );
      });

      _resetRescheduleState(context);
    });
  }

  /// Navigates back to previous screen
  void _returnToPreviousScreen(BuildContext context) => AppRouter.pop(context);

  /// Resets the reschedule state in cubit
  void _resetRescheduleState(BuildContext context) =>
      context.read<AppointmentCubit>().resetRescheduleAppointmentState();
}
