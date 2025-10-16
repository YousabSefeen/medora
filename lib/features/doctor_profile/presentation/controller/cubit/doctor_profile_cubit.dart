import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_profile/presentation/controller/i_doctor_profile_manager.dart' show IDoctorProfileManager;
import 'package:medora/features/shared/models/availability_model.dart' show DoctorAvailabilityModel;


import '../../../data/models/doctor_model.dart';
import '../../../data/repository/doctor_profile_repository.dart';
import '../form_controllers/doctor_fields_controllers.dart';
import '../states/doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState>
    implements IDoctorProfileManager {
  final DoctorProfileRepository doctorRepository;

  DoctorProfileCubit({required this.doctorRepository})
      : super(DoctorProfileState.initial());

  /// Medical specialties methods
  @override
  void toggleMedicalSpecialties(String specialty) {
    final updatedMedicalSpecialties =
        List<String>.from(state.selectedSpecialtiesTempList);

    if (updatedMedicalSpecialties.contains(specialty)) {
      updatedMedicalSpecialties.remove(specialty);
    } else {
      updatedMedicalSpecialties.add(specialty);
    }

    emit(
        state.copyWith(selectedSpecialtiesTempList: updatedMedicalSpecialties));
  }

  final int _maxSpecialtiesLimit = 3;

  @override
  bool get canSelectMoreSpecialties =>
      state.selectedSpecialtiesTempList.length < _maxSpecialtiesLimit;

  @override
  void confirmMedicalSpecialtiesSelection() => emit(state.copyWith(
    confirmedSpecialties: state.selectedSpecialtiesTempList,
        filteredSpecialties: AppStrings.allMedicalSpecialties,
        searchTerm: '',
      ));

  @override
  void syncTempSpecialtiesFromConfirmed() => emit(state.copyWith(
        selectedSpecialtiesTempList: state.confirmedSpecialties,
      ));

  @override
  void searchSpecialty(String searchTerm) {
    final lowerCaseSearchTerm = searchTerm.toLowerCase();

    List<String> searchResults;
    if (lowerCaseSearchTerm.isEmpty) {
      searchResults = state.allSpecialties;
    } else {
      searchResults = state.allSpecialties.where((specialty) {
        final lowerCaseSpecialty = specialty.toLowerCase();
        return lowerCaseSpecialty.contains(lowerCaseSearchTerm);
      }).toList();
    }

    final List<String> finalResults = List.from(searchResults);
    finalResults.removeWhere(
      (specialty) => state.selectedSpecialtiesTempList.contains(specialty),
    );

    final List<String> combinedList = [
      ...state.selectedSpecialtiesTempList,
      ...finalResults,
    ];

    emit(state.copyWith(
      filteredSpecialties: combinedList,
      searchTerm: searchTerm,
    ));
  }

  @override
  String get getLastSearchTerm => state.searchTerm;

  @override
  List<String> get getFilteredSpecialties => state.filteredSpecialties;

  /// Working days methods
  @override
  void toggleWorkingDay(String day) {
    final updatedDays = List<String>.from(state.selectedDaysTempList);
    if (updatedDays.contains(day)) {
      updatedDays.remove(day);
    } else {
      updatedDays.add(day);
    }
    emit(state.copyWith(selectedDaysTempList: updatedDays));
  }

  @override
  void confirmWorkingDaysSelection() => emit(state.copyWith(
        confirmedDays: state.selectedDaysTempList,
      ));

  @override
  void syncTempDaysFromConfirmed() => emit(state.copyWith(
        selectedDaysTempList: state.confirmedDays,
      ));

  /// Working Hours methods
  @override
  void toggleWorkHoursExpanded() => emit(
        state.copyWith(isWorkHoursExpanded: !state.isWorkHoursExpanded),
      );

  final Map<String, String> _workHoursSelected = {};

  @override
  void updateWorkHoursSelected(
      bool isTimeRangeEmpty, String? from, String? to) {
    if (!isTimeRangeEmpty) {
      _workHoursSelected.clear();
    } else {
      _workHoursSelected.addAll({AppStrings.from: from!, AppStrings.to: to!});
    }
    emit(state.copyWith(workHoursSelected: Map.from(_workHoursSelected)));
  }



  @override
  void validateInputsAndSubmitProfile(DoctorFieldsControllers controllers) {
    _markAsValidatedIfNeeded();

    if (_isFormValid(controllers)) {

      _submitProfile(controllers: controllers);
    }
  }

  void _markAsValidatedIfNeeded() {
    if (!state.hasValidatedBefore) {
      emit(state.copyWith(hasValidatedBefore: true));
    }
  }

  bool _isFormValid(DoctorFieldsControllers controllers) =>
      controllers.formKey.currentState?.validate() ?? false;



  Future<void> _submitProfile({required DoctorFieldsControllers controllers }) async {
    final response = await doctorRepository.uploadDoctorProfile(
      DoctorModel(
        doctorId: FirebaseAuth.instance.currentUser!.uid,
        imageUrl:AppStrings.images[0],
        name: controllers.nameController.text.trim().toLowerCase(),
        specialties: state.confirmedSpecialties,
        bio: controllers.bioController.text.trim().toLowerCase(),
        location: controllers.locationController.text.trim().toLowerCase(),
        doctorAvailability: DoctorAvailabilityModel(
          workingDays: state.confirmedDays,
          availableFrom: state.workHoursSelected[AppStrings.from],
          availableTo: state.workHoursSelected[AppStrings.to],
        ),
        fees: int.parse(controllers.feesController.text.trim()),
      ),
    );

    response.fold(
      (failure) => emit(state.copyWith(
        doctorProfileState: LazyRequestState.error,
        doctorProfileError: failure.toString(),
      )),
      (success) =>
          emit(state.copyWith(doctorProfileState: LazyRequestState.loaded)),
    );
  }

  @override
  void resetStates() => emit(DoctorProfileState.initial());
}