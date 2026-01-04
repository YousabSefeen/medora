import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart' show AutovalidateMode;
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/data/appointment_booking_data.dart' show AppointmentBookingData;


class PatientState extends Equatable {
  final AppointmentBookingData? appointmentBookingData;
  final AutovalidateMode validateMode;
  final GenderType genderType;

  final PatientFieldsControllers? patientFieldsControllers;

  const PatientState({
    this.appointmentBookingData,
    this.validateMode = AutovalidateMode.disabled,
    this.genderType = GenderType.init,

    this.patientFieldsControllers,
  });

  PatientState copyWith({
    AppointmentBookingData? appointmentBookingData,
    AutovalidateMode? validateMode,

    GenderType? genderType,

    PatientFieldsControllers? patientFieldsControllers,
  }) {
    return PatientState(
      appointmentBookingData: appointmentBookingData ?? this.appointmentBookingData,
      validateMode: validateMode ?? this.validateMode,
      genderType: genderType ?? this.genderType,

      patientFieldsControllers:
          patientFieldsControllers ?? this.patientFieldsControllers,
    );
  }

  @override
  List<Object?> get props => [
    appointmentBookingData,
    validateMode,
    genderType,

    patientFieldsControllers,
  ];
}
