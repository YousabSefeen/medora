import 'package:dartz/dartz.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/fetch_completed_appointment_uc.dart'
    show FetchCompletedAppointmentUC;
import 'package:medora/features/appointments/presentation/controller/states/completed_appointments_state.dart'
    show CompletedAppointmentsState;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;

import '../../../../../core/error/failure.dart' show Failure;

class CompletedAppointmentsCubit
    extends
        BasePaginationCubit<
          ClientAppointmentsEntity,
          CompletedAppointmentsState
        > {
  final FetchCompletedAppointmentUC useCase;

  CompletedAppointmentsCubit({required this.useCase})
    : super(const CompletedAppointmentsState());

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>>
  getUseCaseCall(PaginationParameters params) {
    return useCase.call(params);
  }
}
