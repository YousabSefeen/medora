import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/domain/repositories/doctors_list_repository.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart';
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart';
import 'package:medora/features/shared/domain/use_cases/base_pagination_use_case.dart';

class FetchDoctorsListUseCase extends BasePaginationUseCase<DoctorEntity> {
  final DoctorsListRepository _repository;

  FetchDoctorsListUseCase({required this._repository});

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> call(
    PaginationParameters params,
  ) async {
    return await _repository.getDoctorsList(parameters: params);
  }
}
