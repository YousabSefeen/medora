import 'package:equatable/equatable.dart';
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/entities/doctor_appointment_entity.dart'
    show DoctorAppointmentEntity;
import 'package:medora/features/appointments/presentation/view_data/selected_doctor_view_data.dart' show SelectedDoctorViewData;


import '../../../../../core/enum/appointment_availability_status.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/request_state.dart';

class AppointmentState extends Equatable {
  final List<DoctorAppointmentEntity> doctorAppointmentModel;
  final RequestState doctorAppointmentState;
  final String doctorAppointmentError;
  final String? selectedDateFormatted;
  final AppointmentAvailabilityStatus appointmentAvailabilityStatus;
  final List<String> reservedTimeSlots;
  final RequestState reservedTimeSlotsState;
  final String reservedTimeSlotsError;

  final List<String> availableDoctorTimeSlots;

  final String? selectedTimeSlot;
  final SelectedDoctorViewData? selectedDoctor;

  final LazyRequestState bookAppointmentState;
  final String bookAppointmentError;
  final LazyRequestState rescheduleAppointmentState;
  final String rescheduleAppointmentError;
  final LazyRequestState cancelAppointmentState;
  final String cancelAppointmentError;

  final List<ClientAppointmentsEntity> getClientAppointmentsList;
  final RequestState getClientAppointmentsListState;
  final String getClientAppointmentsListError;

  //New

  final LazyRequestState deleteAppointment;
  final String deleteAppointmentError;

  //New New
  final bool hasValidatedBefore;
  final GenderType genderType;

  // Payment Gateways
  final PaymentGatewaysTypes selectedPaymentMethod;

  const AppointmentState({
    this.doctorAppointmentModel = const [],
    this.doctorAppointmentState = RequestState.loading,
    this.doctorAppointmentError = '',
    this.selectedDateFormatted,
    this.appointmentAvailabilityStatus =
        AppointmentAvailabilityStatus.available,
    this.reservedTimeSlots = const [],
    this.reservedTimeSlotsState = RequestState.loading,
    this.reservedTimeSlotsError = '',
    this.availableDoctorTimeSlots = const [],
    this.selectedDoctor,
    this.selectedTimeSlot,
    this.bookAppointmentState = LazyRequestState.lazy,
    this.bookAppointmentError = '',
    this.rescheduleAppointmentState = LazyRequestState.lazy,
    this.rescheduleAppointmentError = '',
    this.cancelAppointmentState = LazyRequestState.lazy,
    this.cancelAppointmentError = '',
    this.getClientAppointmentsList = const [],
    this.getClientAppointmentsListState = RequestState.loading,
    this.getClientAppointmentsListError = '',
    this.deleteAppointment = LazyRequestState.lazy,
    this.deleteAppointmentError = '',
    this.hasValidatedBefore = false,
    this.genderType = GenderType.init,
    this.selectedPaymentMethod = PaymentGatewaysTypes.none,
  });

  AppointmentState copyWith({
    List<DoctorAppointmentEntity>? doctorAppointmentModel,
    RequestState? doctorAppointmentState,
    String? doctorAppointmentError,
    String? selectedDateFormatted,
    AppointmentAvailabilityStatus? appointmentAvailabilityStatus,
    List<String>? reservedTimeSlots,
    RequestState? reservedTimeSlotsState,
    String? reservedTimeSlotsError,
    List<String>? availableDoctorTimeSlots,
    SelectedDoctorViewData? selectedDoctor,
    String? selectedTimeSlot,
    LazyRequestState? bookAppointmentState,
    String? bookAppointmentError,
    LazyRequestState? rescheduleAppointmentState,
    String? rescheduleAppointmentError,
    LazyRequestState? cancelAppointmentState,
    String? cancelAppointmentError,
    List<ClientAppointmentsEntity>? getClientAppointmentsList,
    RequestState? getClientAppointmentsListState,
    String? getClientAppointmentsListError,
    LazyRequestState? deleteAppointment,
    String? deleteAppointmentError,
    bool? hasValidatedBefore,
    GenderType? genderType,
    PaymentGatewaysTypes? selectedPaymentMethod,
    LazyRequestState? payRequestState,
  }) {
    return AppointmentState(
      doctorAppointmentModel:
          doctorAppointmentModel ?? this.doctorAppointmentModel,
      doctorAppointmentState:
          doctorAppointmentState ?? this.doctorAppointmentState,
      doctorAppointmentError:
          doctorAppointmentError ?? this.doctorAppointmentError,
      selectedDateFormatted:
          selectedDateFormatted ?? this.selectedDateFormatted,
      appointmentAvailabilityStatus:
          appointmentAvailabilityStatus ?? this.appointmentAvailabilityStatus,
      reservedTimeSlots: reservedTimeSlots ?? this.reservedTimeSlots,
      reservedTimeSlotsState:
          reservedTimeSlotsState ?? this.reservedTimeSlotsState,
      reservedTimeSlotsError:
          reservedTimeSlotsError ?? this.reservedTimeSlotsError,
      availableDoctorTimeSlots:
          availableDoctorTimeSlots ?? this.availableDoctorTimeSlots,
      selectedDoctor: selectedDoctor ?? this.selectedDoctor,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      bookAppointmentState: bookAppointmentState ?? this.bookAppointmentState,
      bookAppointmentError: bookAppointmentError ?? this.bookAppointmentError,
      rescheduleAppointmentState:
          rescheduleAppointmentState ?? this.rescheduleAppointmentState,
      rescheduleAppointmentError:
          rescheduleAppointmentError ?? this.rescheduleAppointmentError,
      cancelAppointmentState:
          cancelAppointmentState ?? this.cancelAppointmentState,
      cancelAppointmentError:
          cancelAppointmentError ?? this.cancelAppointmentError,
      getClientAppointmentsList:
          getClientAppointmentsList ?? this.getClientAppointmentsList,
      getClientAppointmentsListState:
          getClientAppointmentsListState ?? this.getClientAppointmentsListState,
      getClientAppointmentsListError:
          getClientAppointmentsListError ?? this.getClientAppointmentsListError,
      deleteAppointment: deleteAppointment ?? this.deleteAppointment,
      hasValidatedBefore: hasValidatedBefore ?? this.hasValidatedBefore,
      deleteAppointmentError:
          deleteAppointmentError ?? this.deleteAppointmentError,
      genderType: genderType ?? this.genderType,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    doctorAppointmentModel,
    doctorAppointmentState,
    doctorAppointmentError,
    selectedDateFormatted,
    appointmentAvailabilityStatus,
    reservedTimeSlots,
    reservedTimeSlotsState,
    reservedTimeSlotsError,
    availableDoctorTimeSlots,
    selectedDoctor,
    selectedTimeSlot,
    bookAppointmentState,
    bookAppointmentError,
    rescheduleAppointmentState,
    rescheduleAppointmentError,
    cancelAppointmentState,
    cancelAppointmentError,
    getClientAppointmentsList,
    getClientAppointmentsListState,
    getClientAppointmentsListError,
    deleteAppointment,
    deleteAppointmentError,
    hasValidatedBefore,
    genderType,
    selectedPaymentMethod,
  ];
}
