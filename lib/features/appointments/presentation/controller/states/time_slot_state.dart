// time_slot_state.dart


import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/appointment_availability_status.dart' show AppointmentAvailabilityStatus;
import 'package:medora/core/enum/request_state.dart' show RequestState;

class TimeSlotState extends Equatable {
  final String? selectedDateFormatted;
  final AppointmentAvailabilityStatus availabilityStatus;
  final List<String> reservedTimeSlots;
  final RequestState reservedSlotsState;
  final String reservedSlotsError;
  final List<String> availableDoctorTimeSlots;
  final String? selectedTimeSlot;

  const TimeSlotState({
    this.selectedDateFormatted,
    this.availabilityStatus = AppointmentAvailabilityStatus.available,
    this.reservedTimeSlots = const [],
    this.reservedSlotsState = RequestState.loading,
    this.reservedSlotsError = '',
    this.availableDoctorTimeSlots = const [],
    this.selectedTimeSlot,
  });

  TimeSlotState copyWith({
    String? selectedDateFormatted,
    AppointmentAvailabilityStatus? availabilityStatus,
    List<String>? reservedTimeSlots,
    RequestState? reservedSlotsState,
    String? reservedSlotsError,
    List<String>? availableDoctorTimeSlots,
    String? selectedTimeSlot,
  }) {
    return TimeSlotState(
      selectedDateFormatted: selectedDateFormatted ?? this.selectedDateFormatted,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      reservedTimeSlots: reservedTimeSlots ?? this.reservedTimeSlots,
      reservedSlotsState: reservedSlotsState ?? this.reservedSlotsState,
      reservedSlotsError: reservedSlotsError ?? this.reservedSlotsError,
      availableDoctorTimeSlots: availableDoctorTimeSlots ?? this.availableDoctorTimeSlots,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
    );
  }

  @override
  List<Object?> get props => [
    selectedDateFormatted,
    availabilityStatus,
    reservedTimeSlots,
    reservedSlotsState,
    reservedSlotsError,
    availableDoctorTimeSlots,
    selectedTimeSlot,
  ];
}


