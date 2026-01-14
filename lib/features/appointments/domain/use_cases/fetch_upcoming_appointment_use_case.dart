import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase;
import 'package:medora/core/error/failure.dart';

import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class FetchUpcomingAppointmentUseCase
    extends BaseUseCase<PaginatedDataResponse, PaginationParameters> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  FetchUpcomingAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, PaginatedDataResponse>> call(
    PaginationParameters parameters,
  ) async {
    return await appointmentRepositoryBase.fetchUpcomingAppointments(
      parameters: parameters,
    );
  }
}
