



// core/base_cubit/base_pagination_cubit.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart' show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart' show PaginationParameters;
import 'package:medora/features/shared/presentation/controllers/state/base_pagination_state.dart' show BasePaginationState;

import '../../../../../core/error/failure.dart' show Failure;

abstract class BasePaginationCubit<T, S extends BasePaginationState<T>> extends Cubit<S> {
  BasePaginationCubit(super.initialState);

  // دالة يجب تنفيذها في الـ Cubit الوارث لاستدعاء الـ UseCase الخاص به
  Future<Either<Failure, PaginatedDataResponse<T>>> getUseCaseCall(PaginationParameters params);

  Future<void> fetchInitialList() async {
    if (state.isLoadedBefore) return;
    await _fetchData(isInitial: true);
    emit(state.copyWith(isLoadedBefore: true) as S);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;
    emit(state.copyWith(isLoadingMore: true) as S);
    await _fetchData(isInitial: false);
  }

  Future<void> _fetchData({required bool isInitial}) async {
    final parameters = PaginationParameters(
      lastDocument: isInitial ? null : state.lastDocument,
      limit: 4,
    );

    final response = await getUseCaseCall(parameters);

    response.fold(
          (failure) => emit(state.copyWith(
        requestState: isInitial ? RequestState.error : state.requestState,
        failureMessage: failure.toString(),
        isLoadingMore: false,
      ) as S),
          (data) {
        final List<T> updatedList = isInitial ? data.list : state.dataList + data.list;
        emit(state.copyWith(
          dataList: updatedList,
          requestState: RequestState.loaded,
          lastDocument: data.lastDocument,
          hasMore: data.hasMore,
          isLoadingMore: false,
        ) as S);
      },
    );
  }

}