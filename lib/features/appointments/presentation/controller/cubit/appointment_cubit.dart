import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart'
    show BookAppointmentEntity;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/book_appointment_use_case.dart';
import 'package:medora/features/appointments/domain/use_cases/cancel_appointment_use_case.dart'
    show CancelAppointmentUseCase, CancelAppointmentsParams;
import 'package:medora/features/appointments/domain/use_cases/delete_appointment_use_case.dart'
    show DeleteAppointmentUseCase, DeleteAppointmentParams;
import 'package:medora/features/appointments/domain/use_cases/fetch_booked_time_slots_use_case.dart'
    show FetchBookedTimeSlotsUseCase, FetchBookedTimeSlotsParams;
import 'package:medora/features/appointments/domain/use_cases/fetch_client_appointments_use_case.dart'
    show FetchClientAppointmentsUseCase;
import 'package:medora/features/appointments/domain/use_cases/fetch_doctor_appointments_use_case.dart'
    show FetchDoctorAppointmentsUseCase;
import 'package:medora/features/appointments/domain/use_cases/reschedule_appointment_use_case.dart'
    show RescheduleAppointmentUseCase, RescheduleAppointmentParams;

import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart'
    show AppointmentState;
import 'package:medora/features/appointments/presentation/view_data/selected_doctor_view_data.dart' show SelectedDoctorViewData;


import '../../../../../core/app_settings/controller/cubit/app_settings_cubit.dart';
import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/appointment_status.dart';
import '../../../../../core/enum/internet_state.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';
import '../../../../../core/utils/date_time_formatter.dart';
import '../../../../../core/utils/time_slot_helper.dart';
import '../../../../shared/models/doctor_schedule_model.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final BookAppointmentUseCase bookAppointmentUS;
  final CancelAppointmentUseCase cancelAppointmentUS;
  final DeleteAppointmentUseCase deleteAppointmentUS;
  final FetchClientAppointmentsUseCase fetchClientAppointmentsUseCase;
  final FetchDoctorAppointmentsUseCase fetchDoctorAppointmentsUS;
  final FetchBookedTimeSlotsUseCase fetchBookedTimeSlotsUseCase;

  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;

  AppointmentCubit({
    required this.appSettingsCubit,
    required this.bookAppointmentUS,
    required this.cancelAppointmentUS,
    required this.deleteAppointmentUS,
    required this.fetchClientAppointmentsUseCase,
    required this.fetchDoctorAppointmentsUS,
    required this.fetchBookedTimeSlotsUseCase,
    required this.rescheduleAppointmentUseCase,
  }) : super(const AppointmentState());

  // Public APIs
  Future<void> fetchDoctorAppointments(String doctorId) async {
    final response = await fetchDoctorAppointmentsUS.call(doctorId);
    response.fold(
      (failure) => _emitDoctorAppointmentsError(failure),
      (appointments) => emit(
        state.copyWith(
          doctorAppointmentState: RequestState.loaded,
          doctorAppointmentModel: appointments,
        ),
      ),
    );
  }

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

  void updateSelectedTimeSlot(String selectedSlot) {
    emit(state.copyWith(selectedTimeSlot: selectedSlot));
  }

  /// Reschedule Appointment Process
  Future<void> rescheduleAppointment({
    required String doctorId,
    required String appointmentId,
  }) async {
    if (_isInternetDisconnected()) {
      emit(
        state.copyWith(
          rescheduleAppointmentState: LazyRequestState.error,
          rescheduleAppointmentError: AppStrings.noInternetConnectionErrorMsg,
        ),
      );
      return;
    }

    emit(state.copyWith(rescheduleAppointmentState: LazyRequestState.loading));
    final response = await rescheduleAppointmentUseCase.call(
      RescheduleAppointmentParams(
        doctorId: doctorId,
        appointmentId: appointmentId,
        appointmentDate: state.selectedDateFormatted!,
        appointmentTime: state.selectedTimeSlot!,
      ),
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          rescheduleAppointmentState: LazyRequestState.error,
          rescheduleAppointmentError: failure.toString(),
        ),
      ),
      (_) async {
        await fetchClientAppointmentsWithDoctorDetails();

        emit(
          state.copyWith(rescheduleAppointmentState: LazyRequestState.loaded),
        );
      },
    );
  }

  /// Cancel Appointment Process
  Future<void> cancelAppointment({
    required String doctorId,
    required String appointmentId,
  }) async {
    if (_isInternetDisconnected()) {
      emit(
        state.copyWith(
          cancelAppointmentState: LazyRequestState.error,
          cancelAppointmentError: AppStrings.noInternetConnectionErrorMsg,
        ),
      );
      return;
    }

    emit(state.copyWith(cancelAppointmentState: LazyRequestState.loading));

    final response = await cancelAppointmentUS.call(
      CancelAppointmentsParams(
        doctorId: doctorId,
        appointmentId: appointmentId,
      ),
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          cancelAppointmentState: LazyRequestState.error,
          cancelAppointmentError: failure.toString(),
        ),
      ),
      (_) async {
        await fetchClientAppointmentsWithDoctorDetails();

        emit(state.copyWith(cancelAppointmentState: LazyRequestState.loaded));
      },
    );
  }

  String get selectedTimeSlot {
    return state.selectedTimeSlot ?? 'selectedTimeSlot Null';
  }

  String get selectedDateFormatted {
    return state.selectedDateFormatted ?? 'selectedTimeSlot Null';
  }

  ///
  List<ClientAppointmentsEntity>? get upcomingAppointments {
    final now = DateTime.now();
    return state.getClientAppointmentsList
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.confirmed.name &&
              appointDateFormatted(appointment.appointmentDate).isAfter(now),
        )
        .toList();
  }

  DateTime appointDateFormatted(String appointDate) {
    return DateTimeFormatter.convertDateToString(appointDate);
  }

  List<ClientAppointmentsEntity>? get completedAppointments {
    final now = DateTime.now();
    return state.getClientAppointmentsList
        .where(
          (appointment) =>
              appointment.appointmentStatus ==
                  AppointmentStatus.completed.name ||
              (appointment.appointmentStatus ==
                      AppointmentStatus.confirmed.name &&
                  appointDateFormatted(
                    appointment.appointmentDate,
                  ).isBefore(now)),
        )
        .toList();
  }

  List<ClientAppointmentsEntity>? get cancelledAppointments {
    return state.getClientAppointmentsList
        .where(
          (appointment) =>
              appointment.appointmentStatus == AppointmentStatus.cancelled.name,
        )
        .toList();
  }

  ///
  Future<void> fetchClientAppointmentsWithDoctorDetails() async {
    final response = await fetchClientAppointmentsUseCase.call(
      const NoParams(),
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          getClientAppointmentsListState: RequestState.error,
          getClientAppointmentsListError: failure.toString(),
        ),
      ),
      (appointments) {
        emit(
          state.copyWith(
            getClientAppointmentsList: appointments,
            getClientAppointmentsListState: RequestState.loaded,
          ),
        );
      },
    );
  }

  void resetBookAppointmentState() {
    emit(
      state.copyWith(
        bookAppointmentState: LazyRequestState.lazy,
        hasValidatedBefore: false,
        genderType: GenderType.init,
        bookAppointmentError: '',
      ),
    );
    print('AppointmentCubit.resetBookAppointmentState');
  }

  void resetStates() => emit(const AppointmentState());

  void resetRescheduleAppointmentState() => emit(
    state.copyWith(
      rescheduleAppointmentState: LazyRequestState.lazy,
      rescheduleAppointmentError: '',
    ),
  );

  void resetCancelAppointmentState() => emit(
    state.copyWith(
      cancelAppointmentState: LazyRequestState.lazy,
      cancelAppointmentError: '',
    ),
  );

  // --- Private Helpers ---

  bool _isInternetDisconnected() =>
      appSettingsCubit.state.internetState == InternetState.disconnected;

  void _emitDoctorAppointmentsError(dynamic failure) {
    emit(
      state.copyWith(
        doctorAppointmentState: RequestState.error,
        doctorAppointmentError: failure.toString(),
      ),
    );
  }

  void _clearSelectedTimeSlot() => emit(state.copyWith(selectedTimeSlot: ''));

  Future<void> _loadReservedSlots(String doctorId, String date) async {
    final response = await fetchBookedTimeSlotsUseCase.call(
      FetchBookedTimeSlotsParams(doctorId: doctorId, date: date),
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          reservedTimeSlotsState: RequestState.error,
          reservedTimeSlotsError: failure.toString(),
        ),
      ),
      (slots) => emit(
        state.copyWith(
          reservedTimeSlotsState: RequestState.loaded,
          reservedTimeSlots: slots,
        ),
      ),
    );
  }

  Future<bool> _checkDoctorAvailability({
    required DateTime selectedDate,
    required List<String> workingDays,
  }) async {
    if (TimeSlotHelper.isSelectedDateBeforeToday(selectedDate)) {
      emit(
        state.copyWith(
          appointmentAvailabilityStatus: AppointmentAvailabilityStatus.pastDate,
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

    emit(state.copyWith(appointmentAvailabilityStatus: status));
    return isWorking;
  }

  Future<void> deleteAppointment({
    required String appointmentId,
    required String doctorId,
  }) async {
    final response = await deleteAppointmentUS.call(
      DeleteAppointmentParams(appointmentId: appointmentId, doctorId: doctorId),
    );
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            deleteAppointment: LazyRequestState.error,
            deleteAppointmentError: failure.toString(),
          ),
        );
      },
      (success) {
        emit(state.copyWith(deleteAppointment: LazyRequestState.loaded));
      },
    );
  }

  //***************************************************************

  void cacheSelectedDoctor(SelectedDoctorViewData selectedDoctor) =>
      emit(state.copyWith(selectedDoctor: selectedDoctor));

  SelectedDoctorViewData get pickedDoctorInfo => state.selectedDoctor!;

  void onChangeSelectedGenderIndex(int index) {
    if (index == 0) {
      emit(state.copyWith(genderType: GenderType.male));
    } else {
      emit(state.copyWith(genderType: GenderType.female));
    }
  }

  ///Book Appointment
  PatientFieldsControllers? _cachedControllers;

  void handleSubmitAppointmentRequest({
    required PatientFieldsControllers controllers,
    required String phoneNumber,
  }) {
    _markFormAsValidatedOnce();
    if (_isFormValid(controllers)) {
      _cacheFormInputs(controllers);
      _startBookingWorkflow(phoneNumber: phoneNumber);
    }

    ///   _redirectToPayment(phoneNumber);
  }

  void _markFormAsValidatedOnce() {
    if (!state.hasValidatedBefore) {
      emit(state.copyWith(hasValidatedBefore: true));
    }
  }

  bool _isFormValid(PatientFieldsControllers controllers) {
    final isFormFieldsValid =
        controllers.formKey.currentState?.validate() ?? false;
    final isGenderValid = controllers.genderController.validate();
    return isFormFieldsValid && isGenderValid;
  }

  void _cacheFormInputs(PatientFieldsControllers controllers) {
    _cachedControllers = controllers;
  }

  void _startBookingWorkflow({required String phoneNumber}) =>
      _bookAppointment(phoneNumber: phoneNumber);

  Future<void> _bookAppointment({required String phoneNumber}) async {
    if (_isInternetDisconnected()) {
      emit(
        state.copyWith(
          bookAppointmentState: LazyRequestState.error,
          bookAppointmentError: AppStrings.noInternetConnectionErrorMsg,
        ),
      );
      return;
    }

    emit(state.copyWith(bookAppointmentState: LazyRequestState.loading));

    final response = await bookAppointmentUS.call(
      BookAppointmentParams(
        doctorId: state.selectedDoctor!.doctorId,
        bookAppointmentEntity: _createAppointmentModel(),
      ),
    );

    response.fold(
      (failure) {
        print('AppointmentCubit._bookAppointment  ${failure.toString()}');
        emit(
          state.copyWith(
            bookAppointmentState: LazyRequestState.error,
            bookAppointmentError: failure.toString(),
          ),
        );
      },
      (_) {
        emit(state.copyWith(bookAppointmentState: LazyRequestState.loaded));
      },
    );
  }

  BookAppointmentEntity _createAppointmentModel() => BookAppointmentEntity(
    patientName: _cachedControllers!.nameController.text.trim(),
    patientGender: state.genderType.name,
    patientAge: _cachedControllers!.ageController.text.trim(),
    patientProblem: _cachedControllers!.problemController.text.trim(),
    appointmentStatus: AppointmentStatus.confirmed.name,
    appointmentDate: state.selectedDateFormatted!,
    appointmentTime: state.selectedTimeSlot!,
  );

  // Payment Gateways
  void onChangePaymentMethod(PaymentGatewaysTypes paymentMethod) =>
      emit(state.copyWith(selectedPaymentMethod: paymentMethod));

  PaymentGatewaysTypes get selectedPaymentMethod => state.selectedPaymentMethod;
}
