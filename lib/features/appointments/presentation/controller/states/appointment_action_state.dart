import '../../../../../core/enum/lazy_request_state.dart';

class AppointmentActionState {
  final String? selectedDate;
  final String? selectedTimeSlot;

  final LazyRequestState actionState;
  final String actionError;

  AppointmentActionState({
    this.selectedDate,
    required this.selectedTimeSlot,
    required this.actionState,
    required this.actionError,
  });
}
