import 'package:flutter/material.dart' show AutovalidateMode;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;

import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_state.dart'
    show PatientState;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/data/appointment_booking_data.dart' show AppointmentBookingData;


class PatientCubit extends Cubit<PatientState> {


  PatientCubit( ) : super(const PatientState());

  void cacheSelectedDoctorAndCreatePendingAppointment(
    AppointmentBookingData appointmentDataView,
  ) {
    emit(state.copyWith(appointmentBookingData: appointmentDataView));
  }

  void cachePatientData({required PatientFieldsControllers formControllers}) =>
      emit(state.copyWith(patientFieldsControllers: formControllers));

  PatientFieldsControllers get getPatientData =>
      state.patientFieldsControllers!;

  String get getGender =>
      state.genderType == GenderType.male ? 'male' : 'female';

  AppointmentBookingData get appointmentBookingData => state.appointmentBookingData!;

  void changeValidateMode() =>
      emit(state.copyWith(validateMode: AutovalidateMode.always));

  void onChangeSelectedGenderIndex(int index) {
    if (index == 0) {
      emit(state.copyWith(genderType: GenderType.male));
    } else {
      emit(state.copyWith(genderType: GenderType.female));
    }
  }
}
