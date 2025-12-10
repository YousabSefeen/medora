import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/doctors_specialties/data/repository/specialty_doctors_repository.dart'
    show SpecialtyDoctorsRepository;
import 'package:medora/features/doctors_specialties/presentation/controller/states/specialty_doctors_states.dart'
    show SpecialtyDoctorsStates;

class SpecialtyDoctorsCubit extends Cubit<SpecialtyDoctorsStates> {
  final SpecialtyDoctorsRepository specialtyDoctorsRepository;

  SpecialtyDoctorsCubit({required this.specialtyDoctorsRepository})
    : super(const SpecialtyDoctorsStates());

  Future<void> getDoctorsBySpecialty({required String specialtyName}) async {
    final response = await specialtyDoctorsRepository.getDoctorsBySpecialty(
      specialtyName: specialtyName,
    );

    response.fold(
      (failure) {
        print('SpecialtyDoctorsCubit.getDoctorsBySpecialty failure: $failure');
        emit(
          state.copyWith(
            specialtyDoctorsState: RequestState.error,
            specialtyDoctorsError: failure.toString(),
          ),
        );
      },
      (specialtyDoctorsList) {
        print(
          'SpecialtyDoctorsCubit.getDoctorsBySpecialty $specialtyDoctorsList',
        );
        emit(
          state.copyWith(
            specialtyDoctorsList: specialtyDoctorsList,
            specialtyDoctorsState: RequestState.loaded,
          ),
        );
      },
    );
  }

  void restStates() =>
      emit(state.copyWith(specialtyDoctorsState: RequestState.initial));
}
