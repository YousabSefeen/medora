import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/domain/repositories/doctors_list_repository.dart'
    show DoctorsListRepository;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/domain/use_cases/base_pagination_use_case.dart'
    show BasePaginationUseCase;

class FetchDoctorsListUseCase extends BasePaginationUseCase<DoctorEntity> {
  final DoctorsListRepository _repository;

  FetchDoctorsListUseCase({required DoctorsListRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> call(
    PaginationParameters email,
  ) async {
    return await _repository.getDoctorsList(parameters: email);
  }
}
