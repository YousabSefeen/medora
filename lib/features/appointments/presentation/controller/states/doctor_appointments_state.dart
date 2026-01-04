

import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/entities/doctor_appointment_entity.dart' show DoctorAppointmentEntity;

class DoctorAppointmentsState extends Equatable {
  final List<DoctorAppointmentEntity> appointments;
  final RequestState state;
  final String error;

  const DoctorAppointmentsState({
    this.appointments = const [],
    this.state = RequestState.loading,
    this.error = '',
  });

  DoctorAppointmentsState copyWith({
    List<DoctorAppointmentEntity>? appointments,
    RequestState? state,
    String? error,
  }) {
    return DoctorAppointmentsState(
      appointments: appointments ?? this.appointments,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [appointments, state, error];
}
