import 'package:dartz/dartz.dart';
import 'package:medora/core/base_use_case/base_use_case.dart' show BaseUseCase;
import 'package:medora/core/error/failure.dart';
import 'package:medora/features/doctor_list/domain/repository/doctor_list_repository_base.dart'
    show DoctorListRepositoryBase;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class GetDoctorsListUseCase
    extends BaseUseCase<PaginatedDataResponse, PaginationParameters> {
  final DoctorListRepositoryBase doctorListRepositoryBase;

  GetDoctorsListUseCase({required this.doctorListRepositoryBase});

  @override
  Future<Either<Failure, PaginatedDataResponse>> call(
    PaginationParameters params,
  ) async {
    return await doctorListRepositoryBase.getDoctorsList(params);
  }
}
