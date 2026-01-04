//
//
//
//
// import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
// import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart' show AppSettingsCubit;
// import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
// import 'package:medora/core/enum/internet_state.dart' show InternetState;
// import 'package:medora/core/enum/request_state.dart' show RequestState;
// import 'package:medora/features/appointments/domain/use_cases/cancel_appointment_use_case.dart' show CancelAppointmentUseCase;
// import 'package:medora/features/appointments/domain/use_cases/delete_appointment_use_case.dart' show DeleteAppointmentUseCase;
// import 'package:medora/features/appointments/domain/use_cases/fetch_client_appointments_use_case.dart' show FetchClientAppointmentsUseCase;
// import 'package:medora/features/appointments/domain/use_cases/reschedule_appointment_use_case.dart' show RescheduleAppointmentUseCase, RescheduleAppointmentParams;
// import 'package:medora/features/appointments/presentation/controller/states/client_appointments_state.dart' show ClientAppointmentsState;
//
// class ClientAppointmentsCubit extends Cubit<ClientAppointmentsState> {
//   final FetchClientAppointmentsUseCase fetchClientAppointmentsUseCase;
//   final RescheduleAppointmentUseCase rescheduleAppointmentUseCase;
//   final CancelAppointmentUseCase cancelAppointmentUS;
//   final DeleteAppointmentUseCase deleteAppointmentUS;
//   final AppSettingsCubit appSettingsCubit;
//
//   ClientAppointmentsCubit({
//     required this.fetchClientAppointmentsUseCase,
//     required this.rescheduleAppointmentUseCase,
//     required this.cancelAppointmentUS,
//     required this.deleteAppointmentUS,
//     required this.appSettingsCubit,
//   }) : super(const ClientAppointmentsState());
//
//   Future<void> fetchClientAppointments() async {
//     emit(state.copyWith(state: RequestState.loading));
//
//     final response = await fetchClientAppointmentsUseCase.call(const NoParams());
//
//     response.fold(
//           (failure) => emit(
//         state.copyWith(
//           state: RequestState.error,
//           error: failure.toString(),
//         ),
//       ),
//           (appointments) => emit(
//         state.copyWith(
//           state: RequestState.loaded,
//           appointments: appointments,
//         ),
//       ),
//     );
//   }
//
//   Future<void> rescheduleAppointment({
//     required String doctorId,
//     required String appointmentId,
//     required String date,
//     required String time,
//   }) async {
//     if (_isInternetDisconnected()) return;
//
//     final response = await rescheduleAppointmentUseCase.call(
//       RescheduleAppointmentParams(
//         doctorId: doctorId,
//         appointmentId: appointmentId,
//         appointmentDate: date,
//         appointmentTime: time,
//       ),
//     );
//
//     response.fold(
//           (failure) => null, // Handle error
//           (_) => fetchClientAppointments(),
//     );
//   }
//
//   bool _isInternetDisconnected() =>
//       appSettingsCubit.state.internetState == InternetState.disconnected;
// }