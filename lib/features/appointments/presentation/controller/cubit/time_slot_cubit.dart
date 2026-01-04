import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/enum/appointment_availability_status.dart'
    show AppointmentAvailabilityStatus;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/utils/date_time_formatter.dart'
    show DateTimeFormatter;
import 'package:medora/core/utils/time_slot_helper.dart' show TimeSlotHelper;
import 'package:medora/features/appointments/domain/params/fetch_booked_time_slots_params.dart' show FetchBookedTimeSlotsParams;
import 'package:medora/features/appointments/domain/use_cases/fetch_booked_time_slots_use_case.dart'
    show FetchBookedTimeSlotsUseCase, FetchBookedTimeSlotsParams;
import 'package:medora/features/appointments/presentation/controller/states/time_slot_state.dart'
    show TimeSlotState;
import 'package:medora/features/shared/models/doctor_schedule_model.dart'
    show DoctorScheduleModel;

class TimeSlotCubit extends Cubit<TimeSlotState> {
  final FetchBookedTimeSlotsUseCase fetchBookedTimeSlotsUseCase;

  TimeSlotCubit({required this.fetchBookedTimeSlotsUseCase})
    : super(const TimeSlotState());

  Future<void> getAvailableDoctorTimeSlots({
    required DateTime selectedDate,
    required DoctorScheduleModel doctorSchedule,
  }) async {
    _clearSelectedTimeSlot();

    final isAvailable = await _checkDoctorAvailability(
      selectedDate: selectedDate,
      workingDays: doctorSchedule.doctorAvailability.workingDays,
    );

    if (!isAvailable) return;

    final formattedDate = DateTimeFormatter.convertSelectedDateToString(
      selectedDate,
    );
    emit(state.copyWith(selectedDateFormatted: formattedDate));

    final allTimeSlots = TimeSlotHelper.generateHourlyTimeSlots(
      startTime: doctorSchedule.doctorAvailability.availableFrom!,
      endTime: doctorSchedule.doctorAvailability.availableTo!,
    );

    await _loadReservedSlots(doctorSchedule.doctorId, formattedDate);

    final availableSlots = TimeSlotHelper.filterAvailableTimeSlots(
      totalTimeSlots: allTimeSlots,
      reservedTimeSlots: state.reservedTimeSlots,
    );

    emit(state.copyWith(availableDoctorTimeSlots: availableSlots));
  }

  void updateSelectedTimeSlot(String selectedSlot) => emit(state.copyWith(selectedTimeSlot: selectedSlot));

  Future<bool> _checkDoctorAvailability({
    required DateTime selectedDate,
    required List<String> workingDays,
  }) async {
    if (TimeSlotHelper.isSelectedDateBeforeToday(selectedDate)) {
      emit(
        state.copyWith(
          availabilityStatus: AppointmentAvailabilityStatus.pastDate,
        ),
      );
      return false;
    }

    final isWorking = TimeSlotHelper.doesDoctorWorkOnDate(
      selectedDate: selectedDate,
      doctorWorkingDays: workingDays,
    );

    final status = isWorking
        ? AppointmentAvailabilityStatus.available
        : AppointmentAvailabilityStatus.doctorNotWorkingOnSelectedDate;

    emit(state.copyWith(availabilityStatus: status));
    return isWorking;
  }

  Future<void> _loadReservedSlots(String doctorId, String date) async {
    emit(state.copyWith(reservedSlotsState: RequestState.loading));

    final response = await fetchBookedTimeSlotsUseCase.call(
      FetchBookedTimeSlotsParams(doctorId: doctorId, date: date),
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          reservedSlotsState: RequestState.error,
          reservedSlotsError: failure.toString(),
        ),
      ),
      (slots) => emit(
        state.copyWith(
          reservedSlotsState: RequestState.loaded,
          reservedTimeSlots: slots,
        ),
      ),
    );
  }
  String get selectedTimeSlot {
    return state.selectedTimeSlot ?? 'selectedTimeSlot Null';
  }

  String get selectedDateFormatted {
    return state.selectedDateFormatted ?? 'selectedTimeSlot Null';
  }
  void _clearSelectedTimeSlot() => emit(state.copyWith(selectedTimeSlot: ''));
  void resetStates() => emit(const TimeSlotState());
}
