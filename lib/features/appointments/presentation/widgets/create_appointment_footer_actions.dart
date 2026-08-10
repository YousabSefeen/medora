import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/states/book_appointment_state.dart';
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart';
import 'package:medora/features/appointments/presentation/ui_models/appointment_booking_ui_model.dart';
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart';
import 'package:medora/features/favorites/presentation/widgets/toggle_favorite_button.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

class CreateAppointmentFooterActions extends StatelessWidget {
  final DoctorEntity doctor;

  const CreateAppointmentFooterActions({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TimeSlotCubit, TimeSlotState, String?>(
      selector: (state) => state.selectedTimeSlot,
      builder: (context, selectedTimeSlot) {
        final isTimeSlotSelected = selectedTimeSlot?.isNotEmpty ?? false;

        return _buildAppointmentButton(
          context: context,
          isEnabled: isTimeSlotSelected,
          selectedTimeSlot: selectedTimeSlot,
        );
      },
    );
  }

  Widget _buildAppointmentButton({
    required BuildContext context,

    required bool isEnabled,
    required String? selectedTimeSlot,
  }) {
    return BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
      listenWhen: (previous, current) =>
          previous.bookingStatus != current.bookingStatus,
      buildWhen: (previous, current) =>
          previous.bookingStatus != current.bookingStatus,
      listener: (context, state) {
        _handleAppointmentStateChange(state: state, context: context);
      },
      builder: (context, state) {
        return Row(
          spacing: 15,
          children: [
            ToggleFavoriteButton(doctorInfo: doctor),
            Expanded(
              child: AdaptiveActionButton(
                bottomHeight: 45,
                title: AppStrings.bookAppointment,
                isEnabled: isEnabled,
                isLoading: state.bookingStatus == LazyRequestState.loading,
                onPressed: () => _createAppointment(context, selectedTimeSlot!),
              ),
            ),
            const SizedBox(width: 15),
          ],
        );
      },
    );
  }

  void _createAppointment(BuildContext context, String selectedTimeSlot) {
    final appointmentData = AppointmentBookingUIModel(
      doctorEntity: doctor,

      appointmentDate: _getSelectedDate(context),
      appointmentTime: selectedTimeSlot,
    );

    context.read<BookAppointmentCubit>().saveAndBookAppointment(
      appointmentData,
    );
  }

  void _handleAppointmentStateChange({
    required BookAppointmentState state,
    required BuildContext context,
  }) {
    switch (state.bookingStatus) {
      case LazyRequestState.lazy:
      case LazyRequestState.loading:
        break;

      case LazyRequestState.loaded:
        _navigateToPatientScreen(context);
        break;

      case LazyRequestState.error:
        _showErrorDialog(context, state.bookingError);
        break;
    }
  }

  String _getSelectedDate(BuildContext context) =>
      context.read<TimeSlotCubit>().state.selectedDateFormatted!;

  void _navigateToPatientScreen(BuildContext context) =>
      context.push(AppRouterNames.patientDetails);

  void _showErrorDialog(BuildContext context, String? errorMessage) {
    if (errorMessage != null) {
      AppAlerts.showCustomErrorDialog(context, errorMessage);
    }
  }
}
