import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart'
    show AppSettingsCubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart'
    show BookAppointmentEntity;
import 'package:medora/features/appointments/domain/params/confirm_appointment_params.dart'
    show ConfirmAppointmentParams;
import 'package:medora/features/appointments/domain/use_cases/confirm_appointment_use_case.dart'
    show ConfirmAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/confirm_pending_appointment_state.dart'
    show ConfirmPendingAppointmentState;

class ConfirmPendingAppointmentCubit
    extends Cubit<ConfirmPendingAppointmentState> {
  final ConfirmAppointmentUseCase confirmPendingAppointmentUseCase;

  ConfirmPendingAppointmentCubit({
    required AppSettingsCubit appSettingsCubit,

    required this.confirmPendingAppointmentUseCase,
  }) : super(const ConfirmPendingAppointmentState());

  Future<void> confirmPendingAppointment({
    required BookAppointmentEntity entity,
  }) async {
    print(
      'ConfirmPendingAppointmentCubit.confirmPendingAppointment vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv',
    );
    final response = await confirmPendingAppointmentUseCase.call(
      _confirmAppointmentParams(entity),
    );
    response.fold(
      (failure) {
        print(
          'BookAppointmentCubit.createPendingAppointment ERROR: ${failure.toString()}',
        );
        emit(
          state.copyWith(
            confirmAppointmentState: LazyRequestState.error,
            confirmAppointmentError: failure.toString(),
          ),
        );
      },
      (_) {
        emit(state.copyWith(confirmAppointmentState: LazyRequestState.loaded));
      },
    );
  }

  ConfirmAppointmentParams _confirmAppointmentParams(
    BookAppointmentEntity entity,
  ) {
    return ConfirmAppointmentParams(
      doctorId: entity.doctorId!,
      appointmentId: entity.appointmentId!,
      appointmentDate: entity.appointmentDate,
      appointmentTime: entity.appointmentTime,
      patientName: entity.patientName,
      patientGender: entity.patientGender,
      patientAge: entity.patientAge,
      patientProblem: entity.patientProblem,
    );
  }

  // Payment Gateways
  void onChangePaymentMethod(PaymentGatewaysTypes paymentMethod) =>
      emit(state.copyWith(selectedPaymentMethod: paymentMethod));
}
