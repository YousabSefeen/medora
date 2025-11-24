import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/features/doctor_profile/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/search/data/repository/search_repository.dart'
    show SearchRepository;
import 'package:medora/features/search/presentation/controller/states/home_doctor_search_states.dart'
    show HomeDoctorSearchStates;

class HomeDoctorSearchCubit extends Cubit<HomeDoctorSearchStates> {
  final SearchRepository searchRepository;

  HomeDoctorSearchCubit({required this.searchRepository})
    : super(const HomeDoctorSearchStates());

  void updateDoctorName({String? doctorName}) =>
      emit(state.copyWith(doctorName: doctorName));

  Future<List<DoctorModel>> searchDoctorsInstant(String query) async {
    updateDoctorName(doctorName: query);

    if (query.isEmpty) {
      return [];
    }

    try {
      final response = await searchRepository.searchDoctorsByName(
        doctorName: query.trim().toLowerCase(),
      );

      return response.fold((failure) => [], (doctors) => doctors);
    } catch (e) {
      return [];
    }
  }
}
