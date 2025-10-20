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

  /*  Timer? _debounce;

  void doctorNameFilter({String? doctorName}) {

    emit(state.copyWith(doctorName: doctorName));
    if (state.doctorName == null) return;
    _onSearchQueryChanged();
  }

  void _onSearchQueryChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      if (!state.isSearchingByCriteria) {
        _searchDoctorsByName();
      } else if (state.isSearchingByCriteria) {
        searchDoctorsByCriteria();
      } else {
        // When the search field is cleared, clear the results.
        emit(state.copyWith(searchResults: []));
      }
    });
  }

  Future<void> _searchDoctorsByName() async {

    if (state.doctorName == null || state.doctorName == '') return;
    emit(state.copyWith(searchResultsState: LazyRequestState.loading));
    final lowercasedDoctorName = state.doctorName!.trim().toLowerCase();

    final response = await searchRepository.searchDoctorsByName(
      doctorName: lowercasedDoctorName,
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          searchResultsState: LazyRequestState.error,
          searchResultsErrorMsg: failure.toString(),
        ),
      ),
      (doctorList) => emit(
        state.copyWith(
          searchResults: doctorList,
          searchResultsState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  Future<void> searchDoctorsByCriteria() async {

    _applyDraftToConfirmed();
    if (state.doctorName == null || state.doctorName == '') return;

    emit(state.copyWith(searchResultsState: LazyRequestState.loading));
    final lowercasedDoctorName = state.doctorName!.trim().toLowerCase();
    final lowercasedDoctorLocation = state.draftDoctorLocation
        ?.trim()
        .toLowerCase();

    final response = await searchRepository.searchDoctorsByCriteria(
      doctorName: lowercasedDoctorName,
      priceRange: state.draftPriceRange,
      specialties: state.draftSelectedSpecialties,
      location: lowercasedDoctorLocation,
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          searchResultsState: LazyRequestState.error,
          searchResultsErrorMsg: failure.toString(),
        ),
      ),
      (doctorList) => emit(
        state.copyWith(
          searchResults: doctorList,
          searchResultsState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  void _applyDraftToConfirmed() => emit(
    state.copyWith(
      isSearchingByCriteria: true,
      confirmedPriceRange: state.draftPriceRange,
      confirmedSelectedSpecialties: state.draftSelectedSpecialties,
      confirmedDoctorLocation: state.draftDoctorLocation,
    ),
  );

  void resetDraftFromConfirmed() => emit(
    state.copyWith(
      draftPriceRange: state.confirmedPriceRange ?? const RangeValues(100, 500),
      draftSelectedSpecialties: state.confirmedSelectedSpecialties ?? const [],
      draftDoctorLocation: state.confirmedDoctorLocation ?? '',
    ),
  );

  void resetFilters() {
    emit(
      state.copyWith(
        isSearchingByCriteria: false,

        confirmedPriceRange: const RangeValues(100, 500),
        confirmedSelectedSpecialties: const [],
        confirmedDoctorLocation: '',
      ),
    );
    _searchDoctorsByName();
  }

  */
  Timer? _searchDebounceTimer;

  bool get _hasValidSearchQuery =>
      state.doctorName != null && state.doctorName!.isNotEmpty;

  // ✅ SRP: دالة واحدة مسؤولة عن تحديث الاسم
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

  /// ✅ Apply and activate temporary filters for search
  /// Move filters from draft to confirmed
  void _applyFiltersToSearch() {
    emit(
      state.copyWith(
        searchType: SearchType.byCriteria,
        confirmedPriceRange: state.draftPriceRange,
        confirmedSelectedSpecialties: state.draftSelectedSpecialties,
        confirmedDoctorLocation: state.draftDoctorLocation,
      ),
    );
  }

  /// 🔄 Sync temporary filters with confirmed filters
  /// Used when the filters screen opens to load current values
  void synchronizeDraftFiltersWithConfirmed() {
    emit(
      state.copyWith(
        draftPriceRange:
            state.confirmedPriceRange ?? const RangeValues(100, 500),
        draftSelectedSpecialties:
            state.confirmedSelectedSpecialties ?? const [],
        draftDoctorLocation: state.confirmedDoctorLocation ?? '',
      ),
    );
  }

  String _getNormalizedDoctorName() => state.doctorName!.trim().toLowerCase();

  String? _getNormalizedLocation() =>
      state.draftDoctorLocation?.trim().toLowerCase();

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

  ///cccccccccccccccccccccccccccccccccccccccccccc
  void restStates() => emit(const SearchStates());

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

  // 👇 دوال إدارة التخصصات
  void toggleSpecialty(String specialty) {
    final newSelectedSpecialties = List<String>.from(
      state.draftSelectedSpecialties,
    );

    if (newSelectedSpecialties.contains(specialty)) {
      newSelectedSpecialties.remove(specialty); // 👈 إزالة إذا كانت موجودة
    } else {
      newSelectedSpecialties.add(specialty); // 👈 إضافة إذا لم تكن موجودة
    }

    emit(state.copyWith(draftSelectedSpecialties: newSelectedSpecialties));
  }

  void doctorLocationFilter(String? location) {
    emit(state.copyWith(draftDoctorLocation: location));
  }

  String? get getDoctorLocation => state.draftDoctorLocation;
}

/*
 Last Versionnnnnn
   Timer? _searchDebounceTimer;

  bool get _hasValidSearchQuery =>
      state.doctorName != null && state.doctorName!.isNotEmpty;

  void updateDoctorNameAndSearch({String? doctorName}) {
    emit(state.copyWith(doctorName: doctorName));

    if (!_hasValidSearchQuery) return;

    _executeDebouncedSearch();
  }

  void _executeDebouncedSearch() {


    if (_searchDebounceTimer?.isActive ?? false) {
      _searchDebounceTimer!.cancel();
    }

    _searchDebounceTimer = Timer(const Duration(milliseconds:700), () {
      switch (state.searchType) {
        case SearchType.byName:
          _searchDoctorsByName();
          break;
        case SearchType.byCriteria:
          _searchDoctorsByMultipleCriteria();
          break;
      }
    });
  }


   void onChangeSearchType({required SearchType newSearchType}) {
     emit(state.copyWith(searchType: newSearchType));

      if (state.searchType == SearchType.byName) {

        resetAllFilters	();

        if (!_hasValidSearchQuery) return;
        _searchDoctorsByName();
      }else{
        if (!_hasValidSearchQuery) return;
       _searchDoctorsByMultipleCriteria();

      }


   }
  ///  ️ Search for doctors by name only (Default search)
  /// Used for basic searches without applying filters
  Future<void> _searchDoctorsByName() async {
    emit(state.copyWith(searchResultsState: LazyRequestState.loading));

    final normalizedDoctorName = state.doctorName!.trim().toLowerCase();

    final response = await searchRepository.searchDoctorsByName(
      doctorName: normalizedDoctorName,
    );

    response.fold(
      (failure) => _handleSearchError(failure),
      (doctorList) => _handleSearchSuccess(doctorList),
    );
  }

  /// Advanced search for doctors using multiple criteria
  /// Used when applying filters (price, specialty, location)
  ///

  Future<void> _searchDoctorsByMultipleCriteria() async {
    _applyFiltersToSearch();

    if (!_hasValidSearchQuery) return;

    emit(state.copyWith(searchResultsState: LazyRequestState.loading));

    final normalizedDoctorName = state.doctorName!.trim().toLowerCase();
    final normalizedDoctorLocation = state.draftDoctorLocation
        ?.trim()
        .toLowerCase();

    final response = await searchRepository.searchDoctorsByCriteria(
      doctorName: normalizedDoctorName,
      priceRange: state.draftPriceRange,
      specialties: state.draftSelectedSpecialties,
      location: normalizedDoctorLocation,
    );

    response.fold(
      (failure) => _handleSearchError(failure),
      (doctorList) => _handleSearchSuccess(doctorList),
    );
  }

  /// ✅ Apply and activate temporary filters for search
  /// Move filters from draft to confirmed
  void _applyFiltersToSearch() {
    emit(
      state.copyWith(
        searchType: SearchType.byCriteria,
        confirmedPriceRange: state.draftPriceRange,
        confirmedSelectedSpecialties: state.draftSelectedSpecialties,
        confirmedDoctorLocation: state.draftDoctorLocation,
      ),
    );
  }

  /// 🔄 Sync temporary filters with confirmed filters
  /// Used when the filters screen opens to load current values
  void synchronizeDraftFiltersWithConfirmed() {
    emit(
      state.copyWith(
        draftPriceRange:
            state.confirmedPriceRange ?? const RangeValues(100, 500),
        draftSelectedSpecialties:
            state.confirmedSelectedSpecialties ?? const [],
        draftDoctorLocation: state.confirmedDoctorLocation ?? '',
      ),
    );
  }

  /// 🗑️ Reset all filters to default values
// and run a new search without filters
  void resetAllFilters() {
    emit(
      state.copyWith(
        searchType: SearchType.byName,
        confirmedPriceRange: const RangeValues(100, 500),
        confirmedSelectedSpecialties: const [],
        confirmedDoctorLocation: '',
      ),
    );

    // تنفيذ بحث جديد بدون فلاتر
    _searchDoctorsByName();
  }

  /// ❌ Handling search errors
  void _handleSearchError(Failure failure) {
    emit(
      state.copyWith(
        searchResultsState: LazyRequestState.error,
        searchResultsErrorMsg: failure.toString(),
      ),
    );
  }

  /// ✅ Processing successful search results
  void _handleSearchSuccess(List<DoctorModel> doctorList) {
    emit(
      state.copyWith(
        searchResults: doctorList,
        searchResultsState: LazyRequestState.loaded,
      ),
    );
  }
 */
/*
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

  void doctorNameFilter({String? doctorName}) {

    emit(state.copyWith(doctorName: doctorName));
    if (state.doctorName == null) return;
    _onSearchQueryChanged();
  }

  void _onSearchQueryChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () {
      if (!state.isSearchingByCriteria) {
        _searchDoctorsByName();
      } else if (state.isSearchingByCriteria) {
        searchDoctorsByCriteria();
      } else {
        // When the search field is cleared, clear the results.
        emit(state.copyWith(searchResults: []));
      }
    });
  }

  Future<void> _searchDoctorsByName() async {

    if (state.doctorName == null || state.doctorName == '') return;
    emit(state.copyWith(searchResultsState: LazyRequestState.loading));
    final lowercasedDoctorName = state.doctorName!.trim().toLowerCase();

    final response = await searchRepository.searchDoctorsByName(
      doctorName: lowercasedDoctorName,
    );

    response.fold(
      (failure) => emit(
        state.copyWith(
          searchResultsState: LazyRequestState.error,
          searchResultsErrorMsg: failure.toString(),
        ),
      ),
      (doctorList) => emit(
        state.copyWith(
          searchResults: doctorList,
          searchResultsState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  Future<void> searchDoctorsByCriteria() async {

    _applyDraftToConfirmed();
    if (state.doctorName == null || state.doctorName == '') return;

    emit(state.copyWith(searchResultsState: LazyRequestState.loading));
    final lowercasedDoctorName = state.doctorName!.trim().toLowerCase();
    final lowercasedDoctorLocation = state.draftDoctorLocation
        ?.trim()
        .toLowerCase();

    final response = await searchRepository.searchDoctorsByCriteria(
      doctorName: lowercasedDoctorName,
      priceRange: state.draftPriceRange,
      specialties: state.draftSelectedSpecialties,
      location: lowercasedDoctorLocation,
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          searchResultsState: LazyRequestState.error,
          searchResultsErrorMsg: failure.toString(),
        ),
      ),
      (doctorList) => emit(
        state.copyWith(
          searchResults: doctorList,
          searchResultsState: LazyRequestState.loaded,
        ),
      ),
    );
  }

  void _applyDraftToConfirmed() => emit(
    state.copyWith(
      isSearchingByCriteria: true,
      confirmedPriceRange: state.draftPriceRange,
      confirmedSelectedSpecialties: state.draftSelectedSpecialties,
      confirmedDoctorLocation: state.draftDoctorLocation,
    ),
  );

  void resetDraftFromConfirmed() => emit(
    state.copyWith(
      draftPriceRange: state.confirmedPriceRange ?? const RangeValues(100, 500),
      draftSelectedSpecialties: state.confirmedSelectedSpecialties ?? const [],
      draftDoctorLocation: state.confirmedDoctorLocation ?? '',
    ),
  );

  void resetFilters() {
    emit(
      state.copyWith(
        isSearchingByCriteria: false,

        confirmedPriceRange: const RangeValues(100, 500),
        confirmedSelectedSpecialties: const [],
        confirmedDoctorLocation: '',
      ),
    );
    _searchDoctorsByName();
  }

  void restStates() => emit(const SearchStates());

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

  // 👇 دوال إدارة التخصصات
  void toggleSpecialty(String specialty) {
    final newSelectedSpecialties = List<String>.from(
      state.draftSelectedSpecialties,
    );

    if (newSelectedSpecialties.contains(specialty)) {
      newSelectedSpecialties.remove(specialty); // 👈 إزالة إذا كانت موجودة
    } else {
      newSelectedSpecialties.add(specialty); // 👈 إضافة إذا لم تكن موجودة
    }

    emit(state.copyWith(draftSelectedSpecialties: newSelectedSpecialties));
  }

  void doctorLocationFilter(String? location) {
    emit(state.copyWith(draftDoctorLocation: location));
  }

  String? get getDoctorLocation => state.draftDoctorLocation;
}

 */
