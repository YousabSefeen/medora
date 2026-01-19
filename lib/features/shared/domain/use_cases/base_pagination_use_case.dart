// core/base_use_case/base_pagination_use_case.dart

import 'package:dartz/dartz.dart';
import 'package:medora/core/error/failure.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart' show PaginationParameters;

/// [T] هو نوع الـ Entity الذي سيتم جلبه (مثل ClientAppointmentsEntity)
abstract class BasePaginationUseCase<T>
    extends BaseUseCase<PaginatedDataResponse<T>, PaginationParameters> {

  @override
  Future<Either<Failure, PaginatedDataResponse<T>>> call(PaginationParameters parameters);
}

//----------------------------------------------------------------------------
// هذه الكلاسات المساعدة التي يعتمد عليها الـ UseCase
//----------------------------------------------------------------------------

