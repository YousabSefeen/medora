import 'dart:async';

import 'package:flutter/material.dart' show RangeValues;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/search/data/repository/search_repository.dart'
    show SearchRepository;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;

class SearchCubit extends Cubit<SearchStates> {
  final SearchRepository searchRepository;

  SearchCubit({required this.searchRepository}) : super(const SearchStates());
  Timer? _debounce;

  void onSearchQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      if (query.isNotEmpty) {
        _searchDoctorsByName(doctorName: query);
      } else {
        // When the search field is cleared, clear the results.
        emit(state.copyWith(searchResults: []));
      }
    });
  }

  Future<void> _searchDoctorsByName({required String doctorName}) async {
    emit(state.copyWith(searchResultsState: LazyRequestState.loading));
    final lowercasedDoctorName = doctorName.toLowerCase();

    final response = await searchRepository.searchDoctorsByName(
      doctorName: lowercasedDoctorName,
    );

    response.fold(
      (failure) {
        print('SpecialtyDoctorsCubit.getDoctorsBySpecialty failure: $failure');
        emit(
          state.copyWith(
            searchResultsState: LazyRequestState.error,
            searchResultsErrorMsg: failure.toString(),
          ),
        );
      },
      (doctorList) {
        print('SearchCubit.searchDoctorsByName  $doctorList');
        emit(
          state.copyWith(
            searchResults: doctorList,
            searchResultsState: LazyRequestState.loaded,
          ),
        );
      },
    );
  }

  void updatePriceRange(RangeValues newRangeValues) =>
      emit(state.copyWith(priceRange: newRangeValues));

  void updateMinPrice(double newMinPrice) {
    final clampedMin = newMinPrice.clamp(50, 1500);

    if (clampedMin >= state.priceRange.end) {
      // 👆 If trying to make Min >= Max
      final autoAdjustedMax = clampedMin + 50; // add 50 EGP
      final clampedMax = autoAdjustedMax.clamp(50, 1500);

      emit(
        state.copyWith(
          priceRange: RangeValues(
            clampedMin.roundToDouble(),
            clampedMax.roundToDouble(),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          priceRange: RangeValues(
            clampedMin.roundToDouble(),
            state.priceRange.end,
          ),
        ),
      );
    }
  }

  void updateMaxPrice(double newMaxPrice) {
    final clampedMax = newMaxPrice.clamp(50, 1500);

    if (clampedMax <= state.priceRange.start) {
      // 👆 If trying to make Max <= Min
      final autoAdjustedMin = clampedMax - 50; // subtract 50 EGP
      final clampedMin = autoAdjustedMin.clamp(50, 1500);

      emit(
        state.copyWith(
          priceRange: RangeValues(
            clampedMin.roundToDouble(),
            clampedMax.roundToDouble(),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          priceRange: RangeValues(
            state.priceRange.start,
            clampedMax.roundToDouble(),
          ),
        ),
      );
    }
  }

  void restStates() => emit(const SearchStates());
}
