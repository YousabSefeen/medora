import 'package:dartz/dartz.dart';
import 'package:medora/features/doctor_list/domain/use_cases/fetch_doctors_list_use_case.dart'
    show FetchDoctorsListUseCase;
import 'package:medora/features/doctor_list/presentation/controller/states/doctor_list_state.dart'
    show DoctorListState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;

import '../../../../../core/error/failure.dart' show Failure;

class DoctorListCubit
    extends BasePaginationCubit<DoctorEntity, DoctorListState> {
  final FetchDoctorsListUseCase useCase;

  DoctorListCubit({required this.useCase}) : super(const DoctorListState());

  @override
  Future<Either<Failure, PaginatedDataResponse<DoctorEntity>>> getUseCaseCall(
    PaginationParameters params,
  ) {
    return useCase.call(params);
  }
}
