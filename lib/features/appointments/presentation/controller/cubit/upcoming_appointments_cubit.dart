import 'package:dartz/dartz.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity, AppointmentParsing;
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
    if (state.dataList.isEmpty) return;

    final updatedList = state.dataList.map((appointment) {
      if (appointment.appointmentId == appointmentId) {
        return appointment.copyWith(
          appointmentDate: newDate,
          appointmentTime: newTime,
        );
      }
      return appointment;
    }).toList();

    _sortAppointments(updatedList);
    emit(state.copyWith(dataList: updatedList));
  }

  void removeAppointmentLocally({required String appointmentId}) {
    if (state.dataList.isEmpty) return;
    final updatedList = List<ClientAppointmentsEntity>.from(
      state.dataList,
    )..removeWhere((appointment) => appointment.appointmentId == appointmentId);

    emit(state.copyWith(dataList: updatedList));
  }

  void addAppointmentLocally({
    required ClientAppointmentsEntity clientAppointment,
  }) {
    if (state.dataList.isEmpty) return;

    final updatedList = List<ClientAppointmentsEntity>.from(state.dataList)
      ..add(clientAppointment);
    _sortAppointments(updatedList);
    emit(state.copyWith(dataList: updatedList));
  }

  void _sortAppointments(List<ClientAppointmentsEntity> list) {
    list.sort((a, b) {
      final dateTimeA = a.dateTime;
      final dateTimeB = b.dateTime;

      return dateTimeA.compareTo(dateTimeB);
    });
  }
}
