import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show RangeValues;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/search_type.dart' show SearchType;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class HomeDoctorSearchStates extends Equatable {
  final SearchType searchType;
  final List<DoctorModel> searchResults;
  final LazyRequestState searchResultsState;
  final String searchResultsErrorMsg;
  final String? doctorName;
  final RangeValues draftPriceRange;

  final List<String> draftSelectedSpecialties;
  final String? draftDoctorLocation;
  final RangeValues? confirmedPriceRange;

  final List<String>? confirmedSelectedSpecialties;
  final String? confirmedDoctorLocation;

  const HomeDoctorSearchStates({
    this.searchType = SearchType.byName,
    this.searchResults = const [],
    this.searchResultsState = LazyRequestState.lazy,
    this.searchResultsErrorMsg = '',

    this.doctorName,
    this.draftPriceRange = const RangeValues(100, 500),
    this.draftSelectedSpecialties = const [],
    this.draftDoctorLocation,

    this.confirmedPriceRange,
    this.confirmedSelectedSpecialties,
    this.confirmedDoctorLocation,
  });

  HomeDoctorSearchStates copyWith({
    SearchType? searchType,
    List<DoctorModel>? searchResults,
    LazyRequestState? searchResultsState,
    String? searchResultsErrorMsg,

    String? doctorName,
    RangeValues? draftPriceRange,
    List<String>? draftSelectedSpecialties,
    String? draftDoctorLocation,

    RangeValues? confirmedPriceRange,
    List<String>? confirmedSelectedSpecialties,
    String? confirmedDoctorLocation,
  }) {
    return HomeDoctorSearchStates(
      searchType: searchType ?? this.searchType,
      searchResults: searchResults ?? this.searchResults,
      searchResultsState: searchResultsState ?? this.searchResultsState,
      searchResultsErrorMsg:
      searchResultsErrorMsg ?? this.searchResultsErrorMsg,

      doctorName: doctorName ?? this.doctorName,

      draftPriceRange: draftPriceRange ?? this.draftPriceRange,
      draftSelectedSpecialties:
      draftSelectedSpecialties ?? this.draftSelectedSpecialties,
      draftDoctorLocation: draftDoctorLocation ?? this.draftDoctorLocation,

      confirmedPriceRange: confirmedPriceRange ?? this.confirmedPriceRange,
      confirmedSelectedSpecialties:
      confirmedSelectedSpecialties ?? this.confirmedSelectedSpecialties,
      confirmedDoctorLocation:
      confirmedDoctorLocation ?? this.confirmedDoctorLocation,
    );
  }

  @override
  List<Object?> get props => [
    searchType,
    searchResults,
    searchResultsState,
    searchResultsErrorMsg,
    doctorName,

    draftPriceRange,
    draftSelectedSpecialties,
    draftDoctorLocation,

    confirmedPriceRange,
    confirmedSelectedSpecialties,
    confirmedDoctorLocation,
  ];
}
