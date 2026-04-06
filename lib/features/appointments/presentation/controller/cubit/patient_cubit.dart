import 'package:flutter/material.dart' show AutovalidateMode;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/core/extensions/string_extensions.dart'
    show StringExtension;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_state.dart'
    show PatientState;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers, PatientLocalDataSource;
import 'package:medora/features/appointments/presentation/ui_models/appointment_booking_ui_model.dart'
    show AppointmentBookingUIModel;

class PatientCubit extends Cubit<PatientState> {
  final PatientLocalDataSource _localDataSource;

  PatientCubit(this._localDataSource) : super(const PatientState()) {
    // Call the autofill function once the Cubit is created
    _autoFillSavedData();
  }

  void setControllers(PatientFieldsControllers controllers) =>
      emit(state.copyWith(patientFieldsControllers: controllers));

  void loadSavedPatientData() {
    final savedData = _localDataSource.getPatientFields();
    if (savedData != null && state.patientFieldsControllers != null) {
      state.patientFieldsControllers!.fromMap(savedData);
    }
  }

  void _savePatientDataToLocal() async {
    final data = state.patientFieldsControllers?.toMap(state.genderType);
    if (data != null) {
      await _localDataSource.savePatientFields(data);
    }
  }

  void _autoFillSavedData() {
    final Map<String, dynamic>? savedData = _localDataSource.getPatientFields();

    if (savedData != null) {
      state.patientFieldsControllers?.fromMap(savedData);

      if (savedData['gender'] != null) {
        final savedGender = GenderType.values.firstWhere(
          (e) => e.name == savedData['gender'],
          orElse: () => GenderType.init,
        );

        emit(state.copyWith(genderType: savedGender));
      }
    }
  }



  void cacheSelectedDoctorAndCreatePendingAppointment(
    AppointmentBookingUIModel appointmentDataView,
  ) {
    emit(state.copyWith(appointmentBookingUIModel: appointmentDataView));
  }

  void cachePatientData({required PatientFieldsControllers formControllers}) {
    _savePatientDataToLocal();
    emit(state.copyWith(patientFieldsControllers: formControllers));
  }

  PatientFieldsControllers get getPatientData =>
      state.patientFieldsControllers!;

  void changeValidateMode() =>
      emit(state.copyWith(validateMode: AutovalidateMode.always));

  void onChangeSelectedGenderIndex(int index) {
    if (index == 0) {
      emit(state.copyWith(genderType: GenderType.male));
    } else {
      emit(state.copyWith(genderType: GenderType.female));
    }
  }

  String get patientName =>
      state.patientFieldsControllers?.nameController.text ?? '';

  String get patientAge =>
      state.patientFieldsControllers?.ageController.text ?? '';

  String get patientProblem =>
      state.patientFieldsControllers?.problemController.text ?? '';

  String get patientGender => state.genderType.name.toCapitalizeFirstLetter();
}
