import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/domain/params/book_appointment_params.dart'
    show BookAppointmentParams;
import 'package:medora/features/appointments/domain/use_cases/book_appointment_use_case.dart'
    show BookAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/book_appointment_state.dart'
    show BookAppointmentState;
import 'package:medora/features/appointments/presentation/data/appointment_booking_data.dart'
    show AppointmentBookingData;

import '../../../../../core/error/failure.dart' show Failure;

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final BookAppointmentUseCase bookAppointmentUseCase;

  BookAppointmentCubit({
    required this.appSettingsCubit,

    required this.bookAppointmentUseCase,
  }) : super(const BookAppointmentState());

  void saveAndBookAppointment(AppointmentBookingData bookingData) {
    _cacheBookingData(bookingData);
    _processAppointmentBooking();
  }

  void _cacheBookingData(AppointmentBookingData bookingData) =>
      emit(state.copyWith(bookingData: bookingData));

  Future<void> _processAppointmentBooking() async {
    emit(state.copyWith(bookingStatus: LazyRequestState.loading));

    final booking = state.bookingData!;
    final params = _createBookingParams(booking);

    final result = await bookAppointmentUseCase.call(params);

    result.fold(_handleBookingFailure, _handleBookingSuccess);
  }

  BookAppointmentParams _createBookingParams(AppointmentBookingData booking) {
    return BookAppointmentParams(
      doctorId: booking.doctorEntity.doctorId!,
      appointmentDate: booking.appointmentDate,
      appointmentTime: booking.appointmentTime,
    );
  }

  void _handleBookingFailure(Failure failure) {
    emit(
      state.copyWith(
        bookingStatus: LazyRequestState.error,
        bookingError: failure.toString(),
      ),
    );
  }

  void _handleBookingSuccess(String appointmentId) {
    _logSuccessfulBooking(appointmentId);

    emit(
      state.copyWith(
        bookingStatus: LazyRequestState.loaded,
        appointmentId: appointmentId,
      ),
    );
  }

  void _logSuccessfulBooking(String appointmentId) {
    debugPrint('Appointment booked successfully. ID: $appointmentId');
    print('Appointment booked successfully. ID: $appointmentId');
  }

  AppointmentBookingData get appointmentDataView => state.bookingData!;

  String get appointmentId => state.appointmentId;
}
