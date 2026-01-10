import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/use_cases/fetch_upcoming_appointment_use_case.dart'
    show FetchUpcomingAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;

class UpcomingAppointmentsCubit extends Cubit<UpcomingAppointmentsState> {
  final FetchUpcomingAppointmentUseCase upcomingAppointmentsUseCase;

  UpcomingAppointmentsCubit({required this.upcomingAppointmentsUseCase})
    : super(const UpcomingAppointmentsState());

  Future<void> fetchUpcomingAppointments() async {
    final response = await upcomingAppointmentsUseCase.call(const NoParams());
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
