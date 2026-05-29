import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository.dart'
    show AppointmentRepository;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/domain/use_cases/base_pagination_use_case.dart'
    show BasePaginationUseCase;



class FetchUpcomingAppointmentUC
    extends BasePaginationUseCase<ClientAppointmentsEntity> {
  final AppointmentRepository repository;

  FetchUpcomingAppointmentUC({required this.repository});

  @override
  Future<Either<Failure, PaginatedDataResponse<ClientAppointmentsEntity>>> call(
    PaginationParameters parameters,
  ) async {
    return await repository.fetchUpcomingAppointments(parameters: parameters);
  }
}
