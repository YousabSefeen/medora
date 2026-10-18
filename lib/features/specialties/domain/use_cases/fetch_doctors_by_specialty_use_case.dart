import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../shared/domain/entities/doctor_entity.dart';
import '../../../shared/domain/entities/paginated_data_response.dart';
import '../../../shared/domain/entities/pagination_parameters.dart';
import '../../../shared/domain/use_cases/base_pagination_use_case.dart';
import '../params/fetch_doctors_by_specialty_params.dart';
import '../repositories/specialties_repository.dart';

class GetDoctorsBySpecialtyUseCase extends BasePaginationUseCase<DoctorEntity> {
  final SpecialtiesRepository specialtiesRepository;
  final String specialtyName; // Sent when the UseCase is created from the Cubit

  GetDoctorsBySpecialtyUseCase({
    required this.specialtiesRepository,
    required this.specialtyName,
  });

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> call(
    PaginationParameters params,
  ) async {
    // Merge paginationParams with the specialization name
    final specialtyParams =
        GetDoctorsBySpecialtyParameters.fromPaginationParams(
          paginationParams: params,
          specialtyName: specialtyName,
        );

    return await specialtiesRepository.fetchDoctorsBySpecialty(
      parameters: specialtyParams,
    );
  }
}
