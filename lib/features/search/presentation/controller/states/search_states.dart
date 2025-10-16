import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show RangeValues;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class SearchStates extends Equatable {
  final bool isSearchingByCriteria;
  final List<DoctorModel> searchResults;
  final LazyRequestState searchResultsState;
  final String searchResultsErrorMsg;

  final RangeValues priceRange;
  final double? pendingMinPrice;
  final double? pendingMaxPrice;
  final String? doctorName;
  final String? doctorLocation;
  final List<String> selectedSpecialties; // 👈 جديد

  const SearchStates({
    this.isSearchingByCriteria =false,
    this.searchResults = const [],
    this.searchResultsState = LazyRequestState.lazy,
    this.searchResultsErrorMsg = '',

    this.priceRange = const RangeValues(100, 500),
    this.pendingMinPrice,
    this.pendingMaxPrice,
    this.doctorName  ,
    this.doctorLocation,
    this.selectedSpecialties = const [], // 👈 جديد - Set لمنع التكرار
  });

  SearchStates copyWith({
    bool? isSearchingByCriteria,
    List<DoctorModel>? searchResults,
    LazyRequestState? searchResultsState,
    String? searchResultsErrorMsg,

    RangeValues? priceRange,
    double? pendingMinPrice,
    double? pendingMaxPrice,

    String? doctorName,
    String? doctorLocation,

    List<String>? selectedSpecialties, // 👈 جديد
  }) {
    return SearchStates(
      isSearchingByCriteria: isSearchingByCriteria ?? this.isSearchingByCriteria,
      searchResults: searchResults ?? this.searchResults,
      searchResultsState: searchResultsState ?? this.searchResultsState,
      searchResultsErrorMsg:
          searchResultsErrorMsg ?? this.searchResultsErrorMsg,

      priceRange: priceRange ?? this.priceRange,
      pendingMinPrice: pendingMinPrice ?? this.pendingMinPrice,
      pendingMaxPrice: pendingMaxPrice ?? this.pendingMaxPrice,

      doctorName: doctorName ?? this.doctorName,

      doctorLocation: doctorLocation ?? this.doctorLocation,

      selectedSpecialties:
          selectedSpecialties ?? this.selectedSpecialties, // 👈 جديد
    );
  }

  @override
  List<Object?> get props => [
    isSearchingByCriteria,
    searchResults,
    searchResultsState,
    searchResultsErrorMsg,

    priceRange,
    pendingMinPrice,
    pendingMaxPrice,

    doctorName,

    doctorLocation,

    selectedSpecialties,
  ];
}
