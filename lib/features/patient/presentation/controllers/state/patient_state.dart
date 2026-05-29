import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart' show AutovalidateMode;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/appointments/presentation/ui_models/appointment_booking_ui_model.dart'
    show AppointmentBookingUIModel;
import 'package:medora/features/patient/presentation/widgets/patient_fields_controllers.dart'
    show PatientFieldsControllers;

class PatientState extends Equatable {
  final LazyRequestState getPatientDataState;
  final AppointmentBookingUIModel? appointmentBookingUIModel;
  final AutovalidateMode validateMode;
  final GenderType genderType;

  final PatientFieldsControllers? patientFieldsControllers;

  const PatientState({
    this.getPatientDataState = LazyRequestState.lazy,
    this.appointmentBookingUIModel,
    this.validateMode = AutovalidateMode.disabled,
    this.genderType = GenderType.init,
    this.patientFieldsControllers,
  });

  PatientState copyWith({
    LazyRequestState? getPatientDataState,
    AppointmentBookingUIModel? appointmentBookingUIModel,
    AutovalidateMode? validateMode,
    GenderType? genderType,
    PatientFieldsControllers? patientFieldsControllers,
  }) {
    return PatientState(
      getPatientDataState: getPatientDataState ?? this.getPatientDataState,
      appointmentBookingUIModel:
          appointmentBookingUIModel ?? this.appointmentBookingUIModel,
      validateMode: validateMode ?? this.validateMode,
      genderType: genderType ?? this.genderType,
      patientFieldsControllers:
          patientFieldsControllers ?? this.patientFieldsControllers,
    );
  }

  @override
  List<Object?> get props => [
    getPatientDataState,
    appointmentBookingUIModel,
    validateMode,
    genderType,
    patientFieldsControllers,
  ];
}
