import 'package:flutter/material.dart' show AutovalidateMode;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/extensions/string_extensions.dart'
    show StringExtension;
import 'package:medora/features/appointments/domain/entities/patient_entity.dart'
    show PatientEntity;
import 'package:medora/features/appointments/domain/use_cases/get_cached_patient_data_use_case.dart'
    show GetCachedPatientDataUseCase;
import 'package:medora/features/appointments/domain/use_cases/save_patient_data_use_case.dart'
    show SavePatientDataUseCase;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_state.dart'
    show PatientState;
import 'package:medora/features/appointments/presentation/widgets/patient_widgets/patient_fields_controllers.dart'
    show PatientFieldsControllers;

class PatientCubit extends Cubit<PatientState> {
  final SavePatientDataUseCase savePatientDataUseCase;
  final GetCachedPatientDataUseCase getCachedPatientDataUseCase;

  PatientCubit({
    required this.savePatientDataUseCase,
    required this.getCachedPatientDataUseCase,
  }) : super(const PatientState());

  void setControllers(PatientFieldsControllers controllers) =>
      emit(state.copyWith(patientFieldsControllers: controllers));

  void getCachedPatientData() async {
    emit(state.copyWith(getPatientDataState: LazyRequestState.loading));
    final result = await getCachedPatientDataUseCase.call(const NoParams());

    result.fold(
      (failure) {
        emit(state.copyWith(getPatientDataState: LazyRequestState.error));
      },
      (patient) {
        if (patient != null) {
          state.patientFieldsControllers!.nameController.text = patient.name;
          state.patientFieldsControllers!.ageController.text = patient.age;
          state.patientFieldsControllers!.problemController.text =
              patient.problem;

          emit(
            state.copyWith(
              getPatientDataState: LazyRequestState.loaded,
              genderType: patient.gender,
            ),
          );
        }
      },
    );
  }

  void cachePatientData({required PatientFieldsControllers formControllers}) {
    emit(state.copyWith(patientFieldsControllers: formControllers));
    _savePatientData();
  }

  Future<void> _savePatientData() async {
    if (state.patientFieldsControllers == null) return;

    final patientEntity = PatientEntity(
      name: state.patientFieldsControllers!.nameController.text,
      age: state.patientFieldsControllers!.ageController.text,
      problem: state.patientFieldsControllers!.problemController.text,
      gender: state.genderType,
    );

    await savePatientDataUseCase.call((patientEntity));
  }

  void changeValidateMode() =>
      emit(state.copyWith(validateMode: AutovalidateMode.always));

  void onChangeSelectedGenderIndex(int index) {
    final gender = index == 0 ? GenderType.male : GenderType.female;
    emit(state.copyWith(genderType: gender));
  }

  String get patientName =>
      state.patientFieldsControllers?.nameController.text ?? '';

  String get patientAge =>
      state.patientFieldsControllers?.ageController.text ?? '';

  String get patientProblem =>
      state.patientFieldsControllers?.problemController.text ?? '';

  String get patientGender => state.genderType.name.toCapitalizeFirstLetter();
}
