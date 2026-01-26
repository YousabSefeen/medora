import 'package:dartz/dartz.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/fetch_upcoming_appointment_uc.dart'
    show FetchUpcomingAppointmentUC;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;

import '../../../../../core/error/failure.dart' show Failure;

class UpcomingAppointmentsCubit
    extends
        BasePaginationCubit<
          ClientAppointmentsEntity,
          UpcomingAppointmentsState
        > {
  final FetchUpcomingAppointmentUC useCase;

  UpcomingAppointmentsCubit({required this.useCase})
    : super(const UpcomingAppointmentsState());

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>>
  getUseCaseCall(PaginationParameters params) {
    return useCase.call(params);
  }

  void updateAppointmentLocally({
    required String appointmentId,
    required String newDate,
    required String newTime,
  }) {
    final updatedList = state.dataList.map((appointment) {
      if (appointment.appointmentId == appointmentId) {
        return appointment.copyWith(
          appointmentDate: newDate,
          appointmentTime: newTime,
        );
      }
      return appointment;
    }).toList();

    emit(state.copyWith(dataList: updatedList));
  }

  void removeAppointmentLocally({required String appointmentId}) {
    final updatedList = state.dataList
        .where((appointment) => appointment.appointmentId != appointmentId)
        .toList();

    emit(state.copyWith(dataList: updatedList));
  }
}
