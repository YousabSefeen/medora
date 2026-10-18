import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/di/injection_container.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/domain/use_cases/reschedule_appointment_use_case.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/reschedule_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart';
import 'package:medora/features/appointments/presentation/widgets/booked_appointment_widgets/reschedule_success_dialog.dart';
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart';
import 'package:medora/features/appointments/presentation/widgets/doctor_appointment_booking_section.dart';
import 'package:medora/features/shared/models/doctor_schedule_model.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../../core/animations/custom_modal_type_bottom_sheet.dart';
import '../../../../../core/constants/app_alerts/widgets/app_alert_widgets.dart';
import '../../controller/cubit/upcoming_appointments_cubit.dart';
import '../../controller/states/reschedule_appointment_state.dart';
import '../../ui_models/appointment_reschedule_ui_model.dart';

abstract class AppointmentRescheduleSheet {
  static void show(BuildContext context, ClientAppointmentsEntity appointment) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => CustomModalTypeBottomSheet(),
      onModalDismissedWithBarrierTap: () => context.pop(),
      pageListBuilder: (modalSheetContext) => [
        WoltModalSheetPage(
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: true,
          topBar: AppAlertWidgets.customSheetTopBar(
            context: context,
            appBarBackgroundColor: AppColors.softBlue,
            appBarTitle: AppStrings.editBookingAppointment,
            appBarTitleColor: AppColors.white,
          ),
          trailingNavBarWidget: IconButton(
            padding: EdgeInsets.all(20.w),
            icon: FaIcon(FontAwesomeIcons.xmark, color: AppColors.white, size: 25.sp),
            onPressed: () => modalSheetContext.pop(),
          ),
          child: _RescheduleSheetContent(appointment: appointment),
        ),
      ],
    );
  }
}

class _RescheduleSheetContent extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const _RescheduleSheetContent({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RescheduleAppointmentCubit>(
      create: (_) => sl<RescheduleAppointmentCubit>(),
      child: BlocListener<RescheduleAppointmentCubit, RescheduleAppointmentState>(
        listenWhen: (prev, curr) => prev.requestState != curr.requestState,
        listener: _handleRescheduleResponse,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorAppointmentBookingSection(
                doctorSchedule: DoctorScheduleModel(
                  doctorId: appointment.doctorId,
                  doctorAvailability: appointment.doctorEntity.doctorAvailability,
                ),
              ),
              SizedBox(height: 24.h),
              _ConfirmButton(appointment: appointment),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRescheduleResponse(BuildContext context, RescheduleAppointmentState state) {
    if (state.requestState == LazyRequestState.error) {
      AppAlerts.showCustomErrorDialog(context, state.failureMessage ?? AppStrings.defaultErrorMessage);
      context.read<RescheduleAppointmentCubit>().resetRescheduleState();
    } else if (state.requestState == LazyRequestState.loaded) {
      _handleSuccessfulReschedule(context);
    }
  }

  void _handleSuccessfulReschedule(BuildContext context) {
    final timeSlotState = context.read<TimeSlotCubit>().state;

    // 1. تحديث الموعد محلياً
    context.read<UpcomingAppointmentsCubit>().updateAppointmentLocally(
      appointmentId: appointment.appointmentId,
      newDate: timeSlotState.selectedDateFormatted!,
      newTime: timeSlotState.selectedTimeSlot!,
    );

    // 2. إغلاق الـ Bottom Sheet
    context.pop();

    // 3. عرض نافذة النجاح
    RescheduleSuccessDialog.show(
      context: context,
      appointmentReschedule: AppointmentRescheduleUIModel(
        oldAppointmentDate: appointment.appointmentDate,
        oldAppointmentTime: appointment.appointmentTime,
        newAppointmentDate: timeSlotState.selectedDateFormatted!,
        newAppointmentTime: timeSlotState.selectedTimeSlot!,
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final ClientAppointmentsEntity appointment;

  const _ConfirmButton({required this.appointment});

  @override
  Widget build(BuildContext context) {
    // استخدام selector أفضل من watch لتجنب البناء المتكرر بدون داعٍ
    final isLoading = context.select<RescheduleAppointmentCubit, bool>(
          (cubit) => cubit.state.requestState == LazyRequestState.loading,
    );

    return BlocBuilder<TimeSlotCubit, TimeSlotState>(
      buildWhen: (prev, curr) =>
      prev.selectedDateFormatted != curr.selectedDateFormatted ||
          prev.selectedTimeSlot != curr.selectedTimeSlot,
      builder: (context, timeSlotState) {
        final isSelected = timeSlotState.selectedTimeSlot?.isNotEmpty ?? false;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: AdaptiveActionButton(
            title: AppStrings.confirmReschedule,
            isEnabled: isSelected,
            isLoading: isLoading,
            onPressed: () {
              context.read<RescheduleAppointmentCubit>().rescheduleAppointment(
                rescheduleAppointmentParams: RescheduleAppointmentParams(
                  doctorId: appointment.doctorId,
                  appointmentId: appointment.appointmentId,
                  appointmentDate: timeSlotState.selectedDateFormatted!,
                  appointmentTime: timeSlotState.selectedTimeSlot!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
