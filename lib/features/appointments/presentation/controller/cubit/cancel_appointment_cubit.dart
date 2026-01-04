import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/enum/internet_state.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/domain/use_cases/cancel_appointment_use_case.dart'
    show CancelAppointmentUseCase, CancelAppointmentsParams;
import 'package:medora/features/appointments/presentation/controller/states/cancel_appointment_state.dart'
    show CancelAppointmentState;

class CancelAppointmentCubit extends Cubit<CancelAppointmentState> {
  final AppSettingsCubit appSettingsCubit;
  final CancelAppointmentUseCase cancelAppointmentUseCase;

  CancelAppointmentCubit({
    required this.appSettingsCubit,
    required this.cancelAppointmentUseCase,
  }) : super(const CancelAppointmentState());

  Future<void> cancelAppointment({
    required String doctorId,
    required String appointmentId,
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

    final response = await cancelAppointmentUseCase.call(
      CancelAppointmentsParams(
        doctorId: doctorId,
        appointmentId: appointmentId,
      ),
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
  void resetCancelAppointmentState() => emit(
    state.copyWith(
      requestState: LazyRequestState.lazy,
      failureMessage: '',
    ),
  );
  bool _isInternetDisconnected() =>
      appSettingsCubit.state.internetState == InternetState.disconnected;
}
