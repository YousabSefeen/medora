import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

class SpecialtyDoctorsStates extends Equatable {
  final List<DoctorModel> specialtyDoctorsList;
  final RequestState specialtyDoctorsState;
  final String specialtyDoctorsError;

  const SpecialtyDoctorsStates({
    this.specialtyDoctorsList = const [],
    this.specialtyDoctorsState = RequestState.loading,
    this.specialtyDoctorsError = '',
  });

  SpecialtyDoctorsStates copyWith({
    List<DoctorModel>? specialtyDoctorsList,
    RequestState? specialtyDoctorsState,
    String? specialtyDoctorsError,
  }) {
    return SpecialtyDoctorsStates(
      specialtyDoctorsList: specialtyDoctorsList ?? this.specialtyDoctorsList,
      specialtyDoctorsState:
          specialtyDoctorsState ?? this.specialtyDoctorsState,
      specialtyDoctorsError:
          specialtyDoctorsError ?? this.specialtyDoctorsError,
    );
  }

  @override
  List<Object?> get props => [
    specialtyDoctorsList,
    specialtyDoctorsState,
    specialtyDoctorsError,
  ];
}
