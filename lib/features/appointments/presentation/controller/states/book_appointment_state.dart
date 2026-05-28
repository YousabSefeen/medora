import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;

import 'package:medora/features/appointments/presentation/ui_models/appointment_booking_ui_model.dart'
    show AppointmentBookingUIModel;
import 'package:medora/features/appointments/presentation/widgets/patient_widgets/patient_fields_controllers.dart' show PatientFieldsControllers;


class BookAppointmentState extends Equatable {

  final AppointmentBookingUIModel? appointmentBookingUIModel;

  final LazyRequestState bookingStatus;
  final String bookingError;
  final String appointmentId;

  const BookAppointmentState({
    this.appointmentBookingUIModel,

    this.bookingStatus = LazyRequestState.lazy,
    this.bookingError = '',
    this.appointmentId = '',
  });

  BookAppointmentState copyWith({
    AppointmentBookingUIModel? appointmentBookingUIModel,

    LazyRequestState? bookingStatus,
    String? bookingError,
    String? appointmentId,
    PatientFieldsControllers? patientFieldsControllers,
  }) {
    return BookAppointmentState(
      appointmentBookingUIModel: appointmentBookingUIModel ??  this.appointmentBookingUIModel,

      bookingStatus:
          bookingStatus ?? this.bookingStatus,
      bookingError:
          bookingError ?? this.bookingError,
      appointmentId: appointmentId ?? this.appointmentId,
    );
  }

  @override
  List<Object?> get props => [
    appointmentBookingUIModel,

    bookingStatus,
    bookingError,
    appointmentId,
  ];
}
