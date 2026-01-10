import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/use_cases/fetch_cancelled_appointment_use_case.dart'
    show FetchCancelledAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/cancelled_appointments_state.dart'
    show CancelledAppointmentsState;

class CancelledAppointmentsCubit extends Cubit<CancelledAppointmentsState> {
  final FetchCancelledAppointmentUseCase cancelledAppointmentUseCase;

  CancelledAppointmentsCubit({required this.cancelledAppointmentUseCase})
    : super(const CancelledAppointmentsState());

  Future<void> fetchCancelledAppointments() async {
    final response = await cancelledAppointmentUseCase.call(const NoParams());
    response.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          failureMessage: failure.toString(),
        ),
      ),
      (appointments) {
        emit(
          state.copyWith(
            appointments: appointments,
            requestState: RequestState.loaded,
          ),
        );
      },
    );
  }
}
