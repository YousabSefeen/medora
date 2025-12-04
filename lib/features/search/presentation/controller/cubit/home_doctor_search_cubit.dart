import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart' show HydratedCubit;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/search/domain/use_cases/search_doctors_by_name_use_case.dart'
    show SearchDoctorsByNameUseCase;
import 'package:medora/features/search/presentation/controller/states/home_doctor_search_states.dart'
    show HomeDoctorSearchStates;

class HomeDoctorSearchCubit extends HydratedCubit<HomeDoctorSearchStates> {
  final SearchDoctorsByNameUseCase searchByName;

  HomeDoctorSearchCubit({required this.searchByName})
    : super(const HomeDoctorSearchStates());

  @override
  HomeDoctorSearchStates? fromJson(Map<String, dynamic> json) =>
      HomeDoctorSearchStates.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomeDoctorSearchStates state) => state.toJson();

  void updateDoctorName({String? doctorName}) =>
      emit(state.copyWith(doctorName: doctorName));

  Future<List<DoctorModel>> searchDoctorsInstant(String query) async {
    updateDoctorName(doctorName: query);

    if (query.isEmpty && state.searchResults.isEmpty) {
      return [];
    }

    try {
      final response = await searchByName.call(query.trim().toLowerCase());

      return response.fold((failure) => [], (doctors) {
        emit(state.copyWith(searchResults: doctors));
        return state.searchResults;
      });
    } catch (e) {
      return [];
    }
  }
}
