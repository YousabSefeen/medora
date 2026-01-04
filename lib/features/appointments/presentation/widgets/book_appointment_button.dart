import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocSelector, BlocConsumer, ReadContext;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart'
    show TimeSlotCubit;
import 'package:medora/features/appointments/presentation/controller/states/book_appointment_state.dart'
    show BookAppointmentState;
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart'
    show TimeSlotState;
import 'package:medora/features/appointments/presentation/data/appointment_booking_data.dart'
    show AppointmentBookingData;
import 'package:medora/features/appointments/presentation/screens/patient_details_screen.dart'
    show PatientDetailsScreen;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class BookAppointmentButton extends StatelessWidget {
  final DoctorEntity doctor;

  const BookAppointmentButton({super.key, required this.doctor});

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
    return BlocConsumer<
      BookAppointmentCubit,
      BookAppointmentState
    >(
      listenWhen: (previous, current) =>
          previous.bookingStatus != current.bookingStatus,
      buildWhen: (previous, current) =>
          previous.bookingStatus != current.bookingStatus,
      listener: (context, state) {
        _handleAppointmentStateChange(state: state, context: context);
      },
      builder: (context, state) {
        return AdaptiveActionButton(
          title: AppStrings.bookAppointment,
          isEnabled: isEnabled,
          isLoading: state.bookingStatus == LazyRequestState.loading,
          onPressed: () => _createAppointment(context, selectedTimeSlot!),
        );
      },
    );
  }

  void _createAppointment(BuildContext context, String selectedTimeSlot) {
    final appointmentData = AppointmentBookingData(
      doctorEntity: doctor,

      appointmentDate: _getSelectedDate(context),
      appointmentTime: selectedTimeSlot,
    );

    context
        .read<BookAppointmentCubit>()
        .saveAndBookAppointment(appointmentData);
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
      AppRouter.push(context, const PatientDetailsScreen());

  void _showErrorDialog(BuildContext context, String? errorMessage) {
    if (errorMessage != null) {
      AppAlerts.showErrorDialog(context, errorMessage);
    }
  }
}
