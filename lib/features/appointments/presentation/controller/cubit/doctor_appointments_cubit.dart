


import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/use_cases/fetch_doctor_appointments_use_case.dart' show FetchDoctorAppointmentsUseCase;
import 'package:medora/features/appointments/presentation/controller/states/doctor_appointments_state.dart' show DoctorAppointmentsState;

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  final FetchDoctorAppointmentsUseCase fetchDoctorAppointmentsUS;

  DoctorAppointmentsCubit({required this.fetchDoctorAppointmentsUS})
      : super(const DoctorAppointmentsState());

  Future<void> fetchDoctorAppointments(String doctorId) async {
    emit(state.copyWith(state: RequestState.loading));

    final response = await fetchDoctorAppointmentsUS.call(doctorId);

    response.fold(
          (failure) => emit(
        state.copyWith(
          state: RequestState.error,
          error: failure.toString(),
        ),
      ),
          (appointments) => emit(
        state.copyWith(
          state: RequestState.loaded,
          appointments: appointments,
        ),
      ),
    );
  }
}