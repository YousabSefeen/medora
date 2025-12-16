import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/doctor_list/domain/use_cases/get_doctors_list_use_case.dart'
    show GetDoctorsListUseCase;
import 'package:medora/features/doctor_list/presentation/controller/states/doctor_list_state.dart'
    show DoctorListState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

import '../../../../../core/error/failure.dart' show Failure;

class DoctorListCubit extends Cubit<DoctorListState> {
  final GetDoctorsListUseCase getDoctorsListUseCase;

  DoctorListCubit({required this.getDoctorsListUseCase})
    : super(const DoctorListState());

  //   1. Bringing the list for the first time
  Future<void> getDoctorsList() async {
    if (state.isLoadedBefore) {
      return;
    }
    await _fetchDoctors(isInitial: true);
    emit(state.copyWith(isLoadedBefore: true));
  }

  //2. Load more doctors (called via scroll listener)
  Future<void> loadMoreDoctors() async {
    // Verify that we are not currently in a loading state and that there is more data
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    Future.delayed(const Duration(seconds: 1), () async {
      await _fetchDoctors(isInitial: false);
    });
  }

  Future<void> _fetchDoctors({required bool isInitial}) async {
    final parameters = PaginationParameters(
      lastDocument: isInitial ? null : state.lastDocument,
      limit: 10,
    );

    final Either<Failure, PaginatedDataResponse> response =
        await getDoctorsListUseCase.call(parameters);

    response.fold(
      (Failure failure) => _handleFailure(isInitial, failure),
      (PaginatedDataResponse paginatedDataResponse) =>
          _handleSuccess(paginatedDataResponse, isInitial),
    );
  }

  void _handleFailure(bool isInitial, Failure failure) => emit(
    state.copyWith(
      doctorListState: isInitial ? RequestState.error : state.doctorListState,
      doctorListError: failure.toString(),
      isLoadingMore: false,
    ),
  );

  void _handleSuccess(
    PaginatedDataResponse paginatedDataResponse,
    bool isInitial,
  ) {
    final List<DoctorEntity> newDoctors = paginatedDataResponse.doctors;

    //  Merging lists
    final List<DoctorEntity> updatedList = isInitial
        ? newDoctors // If the load is initial, use the new menu
        : state.doctorList + newDoctors; // If more loads, add to current list

    emit(
      state.copyWith(
        doctorList: updatedList,
        doctorListState: RequestState.loaded,
        // Store the last retrieved document
        lastDocument: paginatedDataResponse.lastDocument,
        // Update status: More available
        hasMore: paginatedDataResponse.hasMore,

        isLoadingMore: false,
      ),
    );
  }
}
