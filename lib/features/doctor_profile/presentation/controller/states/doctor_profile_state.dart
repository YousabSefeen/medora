import 'package:equatable/equatable.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

class DoctorProfileState extends Equatable {
  // Medical specialties variables
  final List<String> selectedSpecialtiesTempList;
  final List<String> confirmedSpecialties;
  final List<String> allSpecialties;
  final List<String> filteredSpecialties;
  final String searchTerm;

// Working days variables
  final List<String> selectedDaysTempList;
  final List<String> confirmedDays;

// Working hours variables
  final bool isWorkHoursExpanded;

  final Map<String, String> workHoursSelected;

  // Form validation variables
  final bool hasValidatedBefore;
  final String? doctorProfileError;


  final LazyRequestState doctorProfileState;

  const DoctorProfileState({
    required this.selectedSpecialtiesTempList,
    required this.confirmedSpecialties,
    required this.allSpecialties,
    required this.filteredSpecialties,
    required this.searchTerm,
    required this.selectedDaysTempList,
    required this.confirmedDays,
    required this.isWorkHoursExpanded,
    required this.workHoursSelected,
    required this.hasValidatedBefore,
    required this.doctorProfileError,
    required this.doctorProfileState,
  });

  factory DoctorProfileState.initial() {
    return const DoctorProfileState(
      selectedSpecialtiesTempList: [],
      confirmedSpecialties: [],
      allSpecialties: AppStrings.allMedicalSpecialties,
      filteredSpecialties: AppStrings.allMedicalSpecialties,
      searchTerm: '',
      selectedDaysTempList: [],
      confirmedDays: [],
      isWorkHoursExpanded: false,
      workHoursSelected: {},
      hasValidatedBefore: false,
      doctorProfileError: '',
      doctorProfileState: LazyRequestState.lazy,
    );
  }

  DoctorProfileState copyWith({
    List<String>? selectedSpecialtiesTempList,
    List<String>? confirmedSpecialties,
    List<String>? allSpecialties,
    List<String>? filteredSpecialties,
    String? searchTerm,
    List<String>? selectedDaysTempList,
    List<String>? confirmedDays,
    bool? isWorkHoursExpanded,
    Map<String, String>? workHoursSelected,
    bool? hasValidatedBefore,
    String? doctorProfileError,
    LazyRequestState? doctorProfileState,
  }) {
    return DoctorProfileState(
      selectedSpecialtiesTempList:
          selectedSpecialtiesTempList ?? this.selectedSpecialtiesTempList,
      confirmedSpecialties: confirmedSpecialties ?? this.confirmedSpecialties,
      allSpecialties: allSpecialties ?? this.allSpecialties,
      filteredSpecialties: filteredSpecialties ?? this.filteredSpecialties,
      searchTerm: searchTerm ?? this.searchTerm,
      selectedDaysTempList: selectedDaysTempList ?? this.selectedDaysTempList,
      confirmedDays: confirmedDays ?? this.confirmedDays,
      isWorkHoursExpanded: isWorkHoursExpanded ?? this.isWorkHoursExpanded,
      workHoursSelected: workHoursSelected ?? this.workHoursSelected,
      hasValidatedBefore: hasValidatedBefore ?? this.hasValidatedBefore,
      doctorProfileError: doctorProfileError ?? this.doctorProfileError,
      doctorProfileState: doctorProfileState ?? this.doctorProfileState,
    );
  }

  @override
  List<Object?> get props => [
        selectedSpecialtiesTempList,
        confirmedSpecialties,
        allSpecialties,
        filteredSpecialties,
        searchTerm,
        selectedDaysTempList,
        confirmedDays,
        isWorkHoursExpanded,
        workHoursSelected,
        hasValidatedBefore,
        doctorProfileError,
        doctorProfileState,
      ];
}
