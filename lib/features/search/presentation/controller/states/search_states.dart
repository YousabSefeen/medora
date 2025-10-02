import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart' show DoctorModel;

class SearchStates extends Equatable {
  final List<DoctorModel> searchResults;
  final LazyRequestState searchResultsState;
  final String searchResultsErrorMsg;

  const SearchStates({
    this.searchResults = const [],
    this.searchResultsState = LazyRequestState.lazy,
    this.searchResultsErrorMsg = '',
  });

  SearchStates copyWith({
    List<DoctorModel>? searchResults,
    LazyRequestState? searchResultsState,
    String? searchResultsErrorMsg,
  }) {
    return SearchStates(
      searchResults: searchResults ?? this.searchResults,
      searchResultsState:
          searchResultsState ?? this.searchResultsState,
      searchResultsErrorMsg:
          searchResultsErrorMsg ?? this.searchResultsErrorMsg,
    );
  }

  @override
  List<Object?> get props => [
        searchResults,
        searchResultsState,
        searchResultsErrorMsg,
      ];
}
