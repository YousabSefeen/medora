import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/search_bar_state.dart' show SearchBarState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;

class HomeDoctorSearchStates extends Equatable {
  final SearchBarState searchBarState;
  final List<DoctorModel> searchResults;

  final String? doctorName;

  const HomeDoctorSearchStates({
    this.searchBarState = SearchBarState.collapsed,
    this.searchResults = const [],

    this.doctorName,
  });

  HomeDoctorSearchStates copyWith({
    SearchBarState? searchBarState,
    List<DoctorModel>? searchResults,

    String? doctorName,
  }) {
    return HomeDoctorSearchStates(
      searchBarState: searchBarState ?? this.searchBarState,
      searchResults: searchResults ?? this.searchResults,

      doctorName: doctorName ?? this.doctorName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'searchBarState': searchBarState.index,
      'searchResults': searchResults.map((doctor) => doctor.toJson()).toList(),

      'doctorName': doctorName,
    };
  }

  factory HomeDoctorSearchStates.fromJson(Map<String, dynamic> json) {
    return HomeDoctorSearchStates(
      searchBarState: SearchBarState.values[json['searchBarState'] ?? 0],
      searchResults:
          (json['searchResults'] as List?)
              ?.map((doctorJson) => DoctorModel.fromJson(doctorJson))
              .toList() ??
          const [],
    );
  }

  @override
  List<Object?> get props => [
    searchBarState,
    doctorName, searchResults];
}
