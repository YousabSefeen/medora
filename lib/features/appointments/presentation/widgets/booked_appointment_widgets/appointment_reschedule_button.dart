import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/reschedule_appointment_use_case.dart'
    show RescheduleAppointmentParams;
import 'package:medora/features/appointments/presentation/controller/cubit/reschedule_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/reschedule_appointment_state.dart';
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart';
import 'package:medora/features/appointments/presentation/ui_models/appointment_reschedule_ui_model.dart'
    show AppointmentRescheduleUIModel;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart';
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart';
import 'package:medora/features/shared/models/doctor_schedule_model.dart';

class AppointmentRescheduleButton extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const AppointmentRescheduleButton({super.key, required this.appointment});

  static const double _horizontalPadding = 10.0;
  static const double _verticalPadding = 30.0;
  static const double _contentSpacing = 30.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _getButtonStyle(context),
      onPressed: () => _showRescheduleBottomSheet(context),
      child: const Text(AppStrings.reschedule),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) =>
      Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: const WidgetStatePropertyAll(AppColors.softBlue),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
      );

  void _showRescheduleBottomSheet(BuildContext context) =>
      AppAlerts.showCustomBottomSheet(
        context: context,
        shouldShowScrollbar: false,
        appBarBackgroundColor: AppColors.softBlue,
        appBarTitle: AppStrings.editBookingAppointment,
        appBarTitleColor: AppColors.white,
        body: _buildRescheduleContent(context),
      );

  Padding _buildRescheduleContent(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: _horizontalPadding,
      vertical: _verticalPadding,
    ),
    child: Column(
      spacing: _contentSpacing,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDoctorBookingSection(),
        _buildRescheduleConfirmationButton(),
      ],
    ),
  );

  DoctorAppointmentBookingSection _buildDoctorBookingSection() =>
      DoctorAppointmentBookingSection(
        doctorSchedule: DoctorScheduleModel(
          doctorId: appointment.doctorId,
          doctorAvailability: appointment.doctorEntity.doctorAvailability,
        ),
      );

  _RescheduleConfirmationButton _buildRescheduleConfirmationButton() =>
      _RescheduleConfirmationButton(
        doctorId: appointment.doctorId,
        appointmentId: appointment.appointmentId,
        originalAppointmentDate: appointment.appointmentDate,
        originalAppointmentTime: appointment.appointmentTime,
      );
}

class _RescheduleConfirmationButton extends StatelessWidget {
  final String doctorId;
  final String appointmentId;
  final String originalAppointmentDate;
  final String originalAppointmentTime;

  const _RescheduleConfirmationButton({
    super.key,
    required this.doctorId,
    required this.appointmentId,
    required this.originalAppointmentDate,
    required this.originalAppointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<RescheduleAppointmentCubit, RescheduleAppointmentState>(
      listenWhen: _shouldListenToStateChanges,
      listener: _handleRescheduleResponse,
      child: BlocBuilder<TimeSlotCubit, TimeSlotState>(
        builder: (context, timeSlotState) {
          final isEnabled = _isTimeSlotSelected(timeSlotState);

          return AdaptiveActionButton(
            title: AppStrings.confirmReschedule,
            isEnabled: isEnabled,
            isLoading: _isRescheduleLoading(context),
            onPressed: () => _executeReschedule(context, timeSlotState),
          );
        },
      ),
    );
  }

  bool _shouldListenToStateChanges(
    RescheduleAppointmentState previous,
    RescheduleAppointmentState current,
  ) => previous.requestState != current.requestState;

  void _handleRescheduleResponse(
    BuildContext context,
    RescheduleAppointmentState state,
  ) {
    switch (state.requestState) {
      case LazyRequestState.error:
        _showRescheduleError(context, state.failureMessage);
        break;

      case LazyRequestState.loaded:
        _handleSuccessfulReschedule(context);
        break;

      case LazyRequestState.lazy:
      case LazyRequestState.loading:
        break;
    }
  }

  bool _isTimeSlotSelected(TimeSlotState state) =>
      state.selectedTimeSlot?.isNotEmpty ?? false;

  bool _isRescheduleLoading(BuildContext context) =>
      context.watch<RescheduleAppointmentCubit>().state.requestState ==
      LazyRequestState.loading;

  void _executeReschedule(BuildContext context, TimeSlotState timeSlotState) {
    final params = _buildRescheduleParams(timeSlotState);

    context.read<RescheduleAppointmentCubit>().rescheduleAppointment(
      rescheduleAppointmentParams: params,
    );
  }

  RescheduleAppointmentParams _buildRescheduleParams(
    TimeSlotState timeSlotState,
  ) => RescheduleAppointmentParams(
    doctorId: doctorId,
    appointmentId: appointmentId,
    appointmentDate: timeSlotState.selectedDateFormatted!,
    appointmentTime: timeSlotState.selectedTimeSlot!,
  );

  void _showRescheduleError(BuildContext context, String? errorMessage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      AppAlerts.showCustomErrorDialog(
        context,
        errorMessage ?? AppStrings.defaultErrorMessage,
      );

      _resetRescheduleState(context);
    });
  }

  void _handleSuccessfulReschedule(BuildContext context) {
    final timeSlotState = context.read<TimeSlotCubit>().state;
    final newDate = timeSlotState.selectedDateFormatted!;
    final newTime = timeSlotState.selectedTimeSlot!;

    context.read<UpcomingAppointmentsCubit>().updateAppointmentLocally(
      appointmentId: appointmentId,
      newDate: newDate,
      newTime: newTime,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      AppRouter.pop(context);
      _showSuccessDialogWithDelay(context);
      _resetRescheduleState(context);
    });
  }

  void _showSuccessDialogWithDelay(BuildContext context) {
    Future.delayed(AppDurations.milliseconds_500, () {
      if (!context.mounted) return;

      final timeSlotCubit = context.read<TimeSlotCubit>().state;
      final rescheduleData = _buildAppointmentRescheduleData(timeSlotCubit);

      AppAlerts.showRescheduleSuccessDialog(
        context: context,
        appointmentReschedule: rescheduleData,
      );
    });
  }

  AppointmentRescheduleUIModel _buildAppointmentRescheduleData(
    TimeSlotState timeSlotState,
  ) => AppointmentRescheduleUIModel(
    oldAppointmentDate: originalAppointmentDate,
    oldAppointmentTime: originalAppointmentTime,
    newAppointmentDate: timeSlotState.selectedDateFormatted!,
    newAppointmentTime: timeSlotState.selectedTimeSlot!,
  );

  void _resetRescheduleState(BuildContext context) =>
      context.read<RescheduleAppointmentCubit>().resetRescheduleState();
}
