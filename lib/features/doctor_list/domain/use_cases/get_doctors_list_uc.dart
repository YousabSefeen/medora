import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/repository/appointment_repository_base.dart'
    show AppointmentRepositoryBase;
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart' show DoctorListRepositoryBase;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/domain/use_cases/base_pagination_use_case.dart'
    show BasePaginationUseCase;



class GetDoctorsListUC
    extends BasePaginationUseCase<DoctorEntity> {
  final DoctorListRepositoryBase repository;

  GetDoctorsListUC({required this.repository});

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> call(
      PaginationParameters parameters,
      ) async {
    return await repository.getDoctorsList(parameters: parameters);
  }
}
