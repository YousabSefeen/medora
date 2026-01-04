import 'package:equatable/equatable.dart' show Equatable;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/presentation/controller/form_contollers/patient_fields_controllers.dart'
    show PatientFieldsControllers;
import 'package:medora/features/appointments/presentation/data/appointment_booking_data.dart' show AppointmentBookingData;


class BookAppointmentState extends Equatable {

  final AppointmentBookingData? bookingData;

  final LazyRequestState bookingStatus;
  final String bookingError;
  final String appointmentId;

  const BookAppointmentState({
    this.bookingData,

    this.bookingStatus = LazyRequestState.lazy,
    this.bookingError = '',
    this.appointmentId = '',
  });

  BookAppointmentState copyWith({
    AppointmentBookingData? bookingData,

    LazyRequestState? bookingStatus,
    String? bookingError,
    String? appointmentId,
    PatientFieldsControllers? patientFieldsControllers,
  }) {
    return BookAppointmentState(
      bookingData: bookingData ??  this.bookingData,

      bookingStatus:
          bookingStatus ?? this.bookingStatus,
      bookingError:
          bookingError ?? this.bookingError,
      appointmentId: appointmentId ?? this.appointmentId,
    );
  }

  @override
  List<Object?> get props => [
    bookingData,

    bookingStatus,
    bookingError,
    appointmentId,
  ];
}
