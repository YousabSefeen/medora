import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase, NoParams;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/data/models/paginated_appointments_response.dart' show PaginatedAppointmentsResponse;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart' show PaginationParameters;

class FetchCompletedAppointmentUseCase
    extends BaseUseCase<PaginatedAppointmentsResponse, PaginationParameters> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  FetchCompletedAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, PaginatedAppointmentsResponse>> call(
      PaginationParameters parameters,
  ) async {
    return await appointmentRepositoryBase.fetchCompletedAppointments(
      parameters: parameters,
    );
  }
}
