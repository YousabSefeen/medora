import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/domain/use_cases/base_pagination_use_case.dart'
    show BasePaginationUseCase;

class FetchCompletedAppointmentUC
    extends BasePaginationUseCase<ClientAppointmentsEntity> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  FetchCompletedAppointmentUC({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>> call(
    PaginationParameters parameters,
  ) async {
    return await appointmentRepositoryBase.fetchCompletedAppointments(
      parameters: parameters,
    );
  }
}
