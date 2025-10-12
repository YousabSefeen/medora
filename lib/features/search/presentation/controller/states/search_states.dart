import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show RangeValues;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class SearchStates extends Equatable {
  final List<DoctorModel> searchResults;
  final LazyRequestState searchResultsState;
  final String searchResultsErrorMsg;

  final RangeValues priceRange;
  final double? pendingMinPrice;
  final double? pendingMaxPrice;

  final List<String> selectedSpecialties; // 👈 جديد

  const SearchStates({
    this.searchResults = const [],
    this.searchResultsState = LazyRequestState.lazy,
    this.searchResultsErrorMsg = '',

    this.priceRange = const RangeValues(100, 500),
    this.pendingMinPrice,
    this.pendingMaxPrice,

    this.selectedSpecialties = const [], // 👈 جديد - Set لمنع التكرار
  });

  SearchStates copyWith({
    List<DoctorModel>? searchResults,
    LazyRequestState? searchResultsState,
    String? searchResultsErrorMsg,

    RangeValues? priceRange,
    double? pendingMinPrice,
    double? pendingMaxPrice,

    List<String>? selectedSpecialties, // 👈 جديد
  }) {
    return SearchStates(
      searchResults: searchResults ?? this.searchResults,
      searchResultsState: searchResultsState ?? this.searchResultsState,
      searchResultsErrorMsg:
          searchResultsErrorMsg ?? this.searchResultsErrorMsg,

      priceRange: priceRange ?? this.priceRange,
      pendingMinPrice: pendingMinPrice ?? this.pendingMinPrice,
      pendingMaxPrice: pendingMaxPrice ?? this.pendingMaxPrice,
      selectedSpecialties: selectedSpecialties ?? this.selectedSpecialties, // 👈 جديد
    );
  }

  @override
  List<Object?> get props => [
    searchResults,
    searchResultsState,
    searchResultsErrorMsg,

    priceRange,
    pendingMinPrice,
    pendingMaxPrice,
    selectedSpecialties,
  ];
}
