import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart'
    show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/data/models/paginated_appointments_response.dart'
    show PaginatedAppointmentsResponse;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class FetchCancelledAppointmentUseCase
    extends BaseUseCase<PaginatedAppointmentsResponse, PaginationParameters> {
  final AppointmentRepositoryBase appointmentRepositoryBase;

  FetchCancelledAppointmentUseCase({required this.appointmentRepositoryBase});

  @override
  Future<Either<Failure, PaginatedAppointmentsResponse>> call(
    PaginationParameters parameters,
  ) async {
    return await appointmentRepositoryBase.fetchCancelledAppointments(
      parameters: parameters,
    );
  }
}
