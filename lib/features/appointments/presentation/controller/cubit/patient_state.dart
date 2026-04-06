import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart' show AutovalidateMode;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/ui_models/appointment_booking_ui_model.dart'
    show AppointmentBookingUIModel;

class PatientState extends Equatable {
  final AppointmentBookingUIModel? appointmentBookingUIModel;
  final AutovalidateMode validateMode;
  final GenderType genderType;

  final PatientFieldsControllers? patientFieldsControllers;

  const PatientState({
    this.appointmentBookingUIModel,
    this.validateMode = AutovalidateMode.disabled,
    this.genderType = GenderType.init,
    this.patientFieldsControllers,
  });

  PatientState copyWith({
    AppointmentBookingUIModel? appointmentBookingUIModel,
    AutovalidateMode? validateMode,
    GenderType? genderType,
    PatientFieldsControllers? patientFieldsControllers,
  }) {
    return PatientState(
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
    appointmentBookingUIModel,
    validateMode,
    genderType,
    patientFieldsControllers,
  ];
}
