import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/appointment_status.dart'
    show AppointmentStatus;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/utils/date_time_formatter.dart'
    show DateTimeFormatter;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/fetch_client_appointments_use_case.dart'
    show FetchClientAppointmentsUseCase;
import 'package:medora/features/appointments/presentation/controller/states/fetch_client_appointments_state.dart'
    show FetchClientAppointmentsState;

class FetchClientAppointmentsCubit extends Cubit<FetchClientAppointmentsState> {
  final FetchClientAppointmentsUseCase fetchClientAppointmentsUseCase;

  FetchClientAppointmentsCubit({required this.fetchClientAppointmentsUseCase})
    : super(const FetchClientAppointmentsState());

  Future<void> fetchClientAppointmentsWithDoctorDetails() async {
    final response = await fetchClientAppointmentsUseCase.call(
      const NoParams(),
    );
    response.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          failureMessage: failure.toString(),
        ),
      ),
      (appointments) {
        emit(
          state.copyWith(
            clientAppointments: appointments,
            requestState: RequestState.loaded,
          ),
        );
      },
    );
  }

  List<ClientAppointmentsEntity>? get upcomingAppointments => state
      .clientAppointments
      .where(
        (appointment) =>
            appointment.appointmentStatus == AppointmentStatus.confirmed.name &&
            _appointDateFormatted(
              appointment.appointmentDate,
            ).isAfter(_dateNow()),
      )
      .toList();

  DateTime _dateNow() => DateTime.now();

  List<ClientAppointmentsEntity>? get completedAppointments => state
      .clientAppointments
      .where(
        (appointment) =>
            appointment.appointmentStatus == AppointmentStatus.completed.name ||
            (appointment.appointmentStatus ==
                    AppointmentStatus.confirmed.name &&
                _appointDateFormatted(
                  appointment.appointmentDate,
                ).isBefore(_dateNow())),
      )
      .toList();

  DateTime _appointDateFormatted(String appointDate) =>
      DateTimeFormatter.convertDateToString(appointDate);

  List<ClientAppointmentsEntity>? get cancelledAppointments => state
      .clientAppointments
      .where(
        (appointment) =>
            appointment.appointmentStatus == AppointmentStatus.cancelled.name,
      )
      .toList();
}
