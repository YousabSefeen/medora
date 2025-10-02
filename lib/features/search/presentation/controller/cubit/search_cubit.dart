

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/search/data/repository/search_repository.dart' show SearchRepository;
import 'package:medora/features/search/presentation/controller/states/search_states.dart' show SearchStates;

class SearchCubit extends Cubit<SearchStates> {
  final SearchRepository searchRepository;

  SearchCubit({required this.searchRepository}) : super(const SearchStates());
  Timer? _debounce;



  void onSearchQueryChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 2), () {
      if (query.isNotEmpty) {
        _searchDoctorsByName(doctorName:  query);
      } else {
        // عند مسح حقل البحث، قم بمسح النتائج
        emit(state.copyWith(searchResults: []));
      }
    });
  }




  Future<void> _searchDoctorsByName({required String doctorName}) async {
    emit(state.copyWith(
      searchResultsState: LazyRequestState.loading,
    ));
    final response =
        await searchRepository.searchDoctorsByName(doctorName: doctorName);

    response.fold((failure) {
      print('SpecialtyDoctorsCubit.getDoctorsBySpecialty failure: $failure');
      emit(state.copyWith(
        searchResultsState: LazyRequestState.error,
        searchResultsErrorMsg: failure.toString(),
      ));
    }, (doctorList) {
      print('SearchCubit.searchDoctorsByName  $doctorList');
      emit(state.copyWith(
        searchResults: doctorList,
        searchResultsState: LazyRequestState.loaded,
      ));
    });
  }

  void restStates() => emit(state.copyWith(
        searchResultsState: LazyRequestState.lazy,
      ));
}
