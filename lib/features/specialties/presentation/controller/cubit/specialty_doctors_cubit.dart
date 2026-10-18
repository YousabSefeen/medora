import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../shared/domain/entities/doctor_entity.dart';
import '../../../../shared/domain/entities/paginated_data_response.dart';
import '../../../../shared/domain/entities/pagination_parameters.dart';
import '../../../../shared/presentation/controllers/cubit/base_pagination_cubit.dart';
import '../../../domain/use_cases/fetch_doctors_by_specialty_use_case.dart';
import '../states/specialty_doctors_state.dart';

class SpecialtyDoctorsCubit
    extends BasePaginationCubit<DoctorEntity, SpecialtyDoctorsState> {
  final GetDoctorsBySpecialtyUseCase getDoctorsBySpecialtyUseCase;

  SpecialtyDoctorsCubit({
    required this.getDoctorsBySpecialtyUseCase,
    required String specialtyName,
  }) : super(SpecialtyDoctorsState(specialtyName: specialtyName));

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> getUseCaseCall(
    PaginationParameters params,
  ) {
    return getDoctorsBySpecialtyUseCase.call(params);
  }
}
