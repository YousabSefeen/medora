import 'dart:async';

import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart' show RangeValues;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/search_type.dart' show SearchType;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart';
import 'package:medora/features/search/data/repository/search_repository.dart'
    show SearchRepository;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;

import '../../../../../core/error/failure.dart' show Failure;

class SearchCubit extends Cubit<SearchStates> {
  final SearchRepository searchRepository;

  SearchCubit({required this.searchRepository}) : super(const SearchStates());

  Timer? _searchDebounceTimer;

  bool get _hasValidSearchQuery =>
      state.doctorName != null && state.doctorName!.isNotEmpty;

  void updateDoctorName({String? doctorName}) {
    emit(state.copyWith(doctorName: doctorName));
    _executeDebouncedSearch();
  }

  void _executeDebouncedSearch() {
    _searchDebounceTimer?.cancel();

    _searchDebounceTimer = Timer(const Duration(milliseconds: 700), () {
      _executeSearchBasedOnType();
    });
  }

  void _executeSearchBasedOnType() {
    if (!_hasValidSearchQuery) {
      emit(state.copyWith(searchResultsState: LazyRequestState.lazy));
    } else {
      switch (state.searchType) {
        case SearchType.byName:
          _searchDoctorsByName();
          break;
        case SearchType.byCriteria:
          _searchDoctorsByMultipleCriteria();
          break;
      }
    }
  }

  Future<void> _searchDoctorsByName() async {
    return _executeSearch(
      searchRepository.searchDoctorsByName(
        doctorName: _getNormalizedDoctorName(),
      ),
    );
  }

  Future<void> _searchDoctorsByMultipleCriteria() async {
    _applyFiltersToSearch();

    return _executeSearch(
      searchRepository.searchDoctorsByCriteria(
        doctorName: _getNormalizedDoctorName(),
        priceRange: state.draftPriceRange,
        specialties: state.draftSelectedSpecialties,
        location: _getNormalizedLocation(),
      ),
    );
  }

  Future<void> _executeSearch(
    Future<Either<Failure, List<DoctorModel>>> searchFuture,
  ) async {
    emit(state.copyWith(searchResultsState: LazyRequestState.loading));

    final response = await searchFuture;

    response.fold(
      (failure) => emit(
        state.copyWith(
          searchResultsState: LazyRequestState.error,
          searchResultsErrorMsg: failure.toString(),
        ),
      ),
      (success) => emit(
        state.copyWith(
          searchResults: success,
          searchResultsState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  String _getNormalizedDoctorName() => state.doctorName!.trim().toLowerCase();

  String? _getNormalizedLocation() =>
      state.draftDoctorLocation?.trim().toLowerCase();

  void updateSearchType(SearchType newSearchType) {
    emit(state.copyWith(searchType: newSearchType));

    if (newSearchType == SearchType.byName) {
      _resetToDefaultSearch();
    }
    _executeSearchBasedOnType();
  }

  void _resetToDefaultSearch() => emit(
    state.copyWith(
      searchType: SearchType.byName,
      confirmedPriceRange: const RangeValues(100, 500),
      confirmedSelectedSpecialties: const [],
      confirmedDoctorLocation: '',
    ),
  );

  /// ✅ Apply and activate temporary filters for search
  /// Move filters from draft to confirmed
  void _applyFiltersToSearch() => emit(
    state.copyWith(
      searchType: SearchType.byCriteria,
      confirmedPriceRange: state.draftPriceRange,
      confirmedSelectedSpecialties: state.draftSelectedSpecialties,
      confirmedDoctorLocation: state.draftDoctorLocation,
    ),
  );

  /// Price Range filter methods

  void updatePriceSlider(RangeValues newRangeValues) =>
      emit(state.copyWith(draftPriceRange: newRangeValues));

  void updateMinPriceField(double newMinPrice) {
    final clampedMin = newMinPrice.clamp(50, 1500);

    if (clampedMin >= state.draftPriceRange.end) {
      // 👆 If trying to make Min >= Max
      final autoAdjustedMax = clampedMin + 50; // add 50 EGP
      final clampedMax = autoAdjustedMax.clamp(50, 1500);

      emit(
        state.copyWith(
          draftPriceRange: RangeValues(
            clampedMin.roundToDouble(),
            clampedMax.roundToDouble(),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          draftPriceRange: RangeValues(
            clampedMin.roundToDouble(),
            state.draftPriceRange.end,
          ),
        ),
      );
    }
  }

  void updateMaxPriceField(double newMaxPrice) {
    final clampedMax = newMaxPrice.clamp(50, 1500);

    if (clampedMax <= state.draftPriceRange.start) {
      // 👆 If trying to make Max <= Min
      final autoAdjustedMin = clampedMax - 50; // subtract 50 EGP
      final clampedMin = autoAdjustedMin.clamp(50, 1500);

      emit(
        state.copyWith(
          draftPriceRange: RangeValues(
            clampedMin.roundToDouble(),
            clampedMax.roundToDouble(),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          draftPriceRange: RangeValues(
            state.draftPriceRange.start,
            clampedMax.roundToDouble(),
          ),
        ),
      );
    }
  }

  /// Medical specialties filter methods

  void toggleSpecialty(String specialty) {
    final newSelectedSpecialties = List<String>.from(
      state.draftSelectedSpecialties,
    );

    if (newSelectedSpecialties.contains(specialty)) {
      newSelectedSpecialties.remove(specialty);
    } else {
      newSelectedSpecialties.add(specialty);
    }

    emit(state.copyWith(draftSelectedSpecialties: newSelectedSpecialties));
  }

  void updateDoctorLocation(String? doctorLocation) =>
      emit(state.copyWith(draftDoctorLocation: doctorLocation));

  String? get getDoctorLocation => state.draftDoctorLocation;

  /// 🔄 Sync temporary filters with confirmed filters
  /// Used when the filters screen opens to load current values
  void synchronizeDraftFiltersWithConfirmed() => emit(
    state.copyWith(
      draftPriceRange: state.confirmedPriceRange ?? const RangeValues(100, 500),
      draftSelectedSpecialties: state.confirmedSelectedSpecialties ?? const [],
      draftDoctorLocation: state.confirmedDoctorLocation ?? '',
    ),
  );
}
