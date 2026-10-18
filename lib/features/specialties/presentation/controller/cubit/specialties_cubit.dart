import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/lazy_request_state.dart';

import '../../../../../core/base_use_case/base_use_case.dart';
import '../../../domain/use_cases/fetch_all_specialties_use_case.dart';
import '../../../domain/use_cases/fetch_doctors_by_specialty_use_case.dart';
import '../../../domain/use_cases/fetch_top_specialties_use_case.dart';
import '../states/specialties_states.dart';

class SpecialtiesCubit extends Cubit<SpecialtiesState> {
  final FetchAllSpecialtiesUseCase _fetchAllSpecialtiesUseCase;
  final FetchTopSpecialtiesUseCase _fetchTopSpecialtiesUseCase;
  //final FetchDoctorsBySpecialtyUseCase _fetchDoctorsBySpecialtyUseCase;

  SpecialtiesCubit({
    required this._fetchAllSpecialtiesUseCase,
    required this._fetchTopSpecialtiesUseCase,
    //required this._fetchDoctorsBySpecialtyUseCase,
  }) : super(const SpecialtiesState());

  Future<void> fetchTopSpecialties() async {
    emit(state.copyWith(topSpecialtiesStatus: LazyRequestState.loading));

    final result = await _fetchTopSpecialtiesUseCase(const NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          topSpecialtiesStatus: LazyRequestState.error,
          topSpecialtiesErrorMessage: failure.errorMessage,
        ),
      ),
      (specialties) => emit(
        state.copyWith(
          topSpecialtiesStatus: LazyRequestState.loaded,
          topSpecialties: specialties,
        ),
      ),
    );
  }

  Future<void> fetchAllSpecialties() async {
    emit(state.copyWith(allSpecialtiesStatus: LazyRequestState.loading));

    final result = await _fetchAllSpecialtiesUseCase(const NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          allSpecialtiesStatus: LazyRequestState.error,
          allSpecialtiesErrorMessage: failure.errorMessage,
        ),
      ),
      (specialties) => emit(
        state.copyWith(
          allSpecialtiesStatus: LazyRequestState.loaded,
          allSpecialties: specialties,
        ),
      ),
    );
  }
}
