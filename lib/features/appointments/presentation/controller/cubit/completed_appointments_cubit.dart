import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/use_cases/fetch_completed_appointment_use_case.dart'
    show FetchCompletedAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/completed_appointments_state.dart'
    show CompletedAppointmentsState;

class CompletedAppointmentsCubit extends Cubit<CompletedAppointmentsState> {
  final FetchCompletedAppointmentUseCase completedAppointmentUseCase;

  CompletedAppointmentsCubit({required this.completedAppointmentUseCase})
    : super(const CompletedAppointmentsState());

  Future<void> fetchCompletedAppointments() async {
    // final response = await completedAppointmentUseCase.call(const NoParams());
    // response.fold(
    //   (failure) => emit(
    //     state.copyWith(
    //       requestState: RequestState.error,
    //       failureMessage: failure.toString(),
    //     ),
    //   ),
    //   (appointments) {
    //     emit(
    //       state.copyWith(
    //         appointments: appointments,
    //         requestState: RequestState.loaded,
    //       ),
    //     );
    //   },
    // );
  }
}
