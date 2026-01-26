import 'package:dartz/dartz.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/fetch_cancelled_appointment_uc.dart'
    show FetchCancelledAppointmentUC;
import 'package:medora/features/appointments/presentation/controller/states/cancelled_appointments_state.dart'
    show CancelledAppointmentsState;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;

import '../../../../../core/error/failure.dart' show Failure;

class CancelledAppointmentsCubit
    extends
        BasePaginationCubit<
          ClientAppointmentsEntity,
          CancelledAppointmentsState
        > {
  final FetchCancelledAppointmentUC useCase;

  CancelledAppointmentsCubit({required this.useCase})
    : super(const CancelledAppointmentsState());

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>>
  getUseCaseCall(PaginationParameters params) {
    return useCase.call(params);
  }
}
