import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart'
    show BookAppointmentEntity;
import 'package:medora/features/appointments/domain/params/book_appointment_params.dart'
    show BookAppointmentParams;
import 'package:medora/features/appointments/domain/use_cases/book_appointment_use_case.dart'
    show BookAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/book_appointment_state.dart'
    show BookAppointmentState;
import 'package:medora/features/appointments/presentation/ui_models/appointment_booking_ui_model.dart'
    show AppointmentBookingUIModel;

import '../../../../../core/error/failure.dart' show Failure;

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final BookAppointmentUseCase bookAppointmentUseCase;

  BookAppointmentCubit({
    required this.appSettingsCubit,

    required this.bookAppointmentUseCase,
  }) : super(const BookAppointmentState());


  void saveAndBookAppointment(AppointmentBookingUIModel bookingData) {
    _cacheBookingData(bookingData);
    _processAppointmentBooking();
  }

  void _cacheBookingData(AppointmentBookingUIModel bookingData) =>
      emit(state.copyWith(appointmentBookingUIModel: bookingData));

  Future<void> _processAppointmentBooking() async {
    emit(state.copyWith(bookingStatus: LazyRequestState.loading));

    final booking = state.appointmentBookingUIModel!;
    final params = _createBookingParams(booking);

    final result = await bookAppointmentUseCase.call(params);

    result.fold(_handleBookingFailure, _handleBookingSuccess);
  }

  BookAppointmentParams _createBookingParams(
    AppointmentBookingUIModel booking,
  ) => BookAppointmentParams(
      doctorId: booking.doctorEntity.doctorId!,
      appointmentDate: booking.appointmentDate,
      appointmentTime: booking.appointmentTime,
    );

  void _handleBookingFailure(Failure failure) => emit(
      state.copyWith(
        bookingStatus: LazyRequestState.error,
        bookingError: failure.toString(),
      ),
    );

  void _handleBookingSuccess(String appointmentId) => emit(
    state.copyWith(
      bookingStatus: LazyRequestState.loaded,
      appointmentId: appointmentId,
    ),
  );

  AppointmentBookingUIModel get bookingDetails =>
      state.appointmentBookingUIModel!;

  BookAppointmentEntity createEntityFromPatientData({
    required String name,
    required String age,
    required String gender,
    required String problem,
  }) => BookAppointmentEntity(
    doctorId: bookingDetails.doctorEntity.doctorId,
    appointmentId: state.appointmentId,
    appointmentDate: bookingDetails.appointmentDate,
    appointmentTime: bookingDetails.appointmentTime,
    patientName: name,
    patientAge: age,
    patientGender: gender,
    patientProblem: problem,
  );
}
