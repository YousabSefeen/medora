import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/internet_state.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/domain/use_cases/reschedule_appointment_use_case.dart'
    show RescheduleAppointmentUseCase, RescheduleAppointmentParams;
import 'package:medora/features/appointments/presentation/controller/states/reschedule_appointment_state.dart'
    show RescheduleAppointmentState;

class RescheduleAppointmentCubit extends Cubit<RescheduleAppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;

  RescheduleAppointmentCubit({
    required this.appSettingsCubit,
    required this.rescheduleAppointmentUseCase,
  }) : super(const RescheduleAppointmentState());

  Future<void> rescheduleAppointment({
    required RescheduleAppointmentParams rescheduleAppointmentParams,
  }) async {
    if (_isInternetDisconnected()) {
      emit(
        state.copyWith(
          requestState: LazyRequestState.error,
          failureMessage: AppStrings.noInternetConnectionErrorMsg,
        ),
      );
      return;
    }

    emit(state.copyWith(requestState: LazyRequestState.loading));

    final response = await rescheduleAppointmentUseCase.call(
      rescheduleAppointmentParams,
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          requestState: LazyRequestState.error,
          failureMessage: failure.toString(),
        ),
      ),
      (_) async {
        ///await fetchClientAppointmentsWithDoctorDetails();

        emit(state.copyWith(requestState: LazyRequestState.loaded));
      },
    );
  }
  /*void updateSelectedTimeSlot(String selectedSlot) {
    emit(state.copyWith(selectedTimeSlot: selectedSlot));
  }*/
  void resetRescheduleState() => emit(
    state.copyWith(requestState: LazyRequestState.lazy, failureMessage: ''),
  );

  bool _isInternetDisconnected() =>
      appSettingsCubit.state.internetState == InternetState.disconnected;
}
