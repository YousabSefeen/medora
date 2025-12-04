import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show RangeValues;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/search_type.dart' show SearchType;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class SearchStates extends Equatable {
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

  const SearchStates({
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

  SearchStates copyWith({
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
    return SearchStates(
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
  Map<String, dynamic> toJson() {
    return {
      'searchType': searchType.index,
      'searchResults': searchResults.map((doctor) => doctor.toJson()).toList(),
      'searchResultsState': searchResultsState.index,
      'searchResultsErrorMsg': searchResultsErrorMsg,
      'doctorName': doctorName,
      'draftPriceRange': {'start': draftPriceRange.start, 'end': draftPriceRange.end},
      'draftSelectedSpecialties': draftSelectedSpecialties,
      'draftDoctorLocation': draftDoctorLocation,
      'confirmedPriceRange': confirmedPriceRange != null
          ? {'start': confirmedPriceRange!.start, 'end': confirmedPriceRange!.end}
          : null,
      'confirmedSelectedSpecialties': confirmedSelectedSpecialties,
      'confirmedDoctorLocation': confirmedDoctorLocation,
    };
  }

  factory SearchStates.fromJson(Map<String, dynamic> json) {
    return SearchStates(
      searchType: SearchType.values[json['searchType'] ?? 0],
      searchResults: (json['searchResults'] as List?)
          ?.map((doctorJson) => DoctorModel.fromJson(doctorJson))
          .toList() ?? const [],
      searchResultsState: LazyRequestState.values[json['searchResultsState'] ?? 0],
      searchResultsErrorMsg: json['searchResultsErrorMsg'] ?? '',
      doctorName: json['doctorName'],
      draftPriceRange: RangeValues(
        (json['draftPriceRange']?['start'] ?? 100).toDouble(),
        (json['draftPriceRange']?['end'] ?? 500).toDouble(),
      ),
      draftSelectedSpecialties: List<String>.from(json['draftSelectedSpecialties'] ?? []),
      draftDoctorLocation: json['draftDoctorLocation'],
      confirmedPriceRange: json['confirmedPriceRange'] != null
          ? RangeValues(
        (json['confirmedPriceRange']?['start'] ?? 100).toDouble(),
        (json['confirmedPriceRange']?['end'] ?? 500).toDouble(),
      )
          : null,
      confirmedSelectedSpecialties: json['confirmedSelectedSpecialties'] != null
          ? List<String>.from(json['confirmedSelectedSpecialties'])
          : null,
      confirmedDoctorLocation: json['confirmedDoctorLocation'],
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
