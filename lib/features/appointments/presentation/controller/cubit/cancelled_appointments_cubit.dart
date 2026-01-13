import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/base_use_case/base_use_case.dart' show NoParams;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/use_cases/fetch_cancelled_appointment_use_case.dart'
    show FetchCancelledAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/cancelled_appointments_state.dart'
    show CancelledAppointmentsState;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart' show PaginationParameters;

class CancelledAppointmentsCubit extends Cubit<CancelledAppointmentsState> {
  final FetchCancelledAppointmentUseCase cancelledAppointmentUseCase;

  CancelledAppointmentsCubit({required this.cancelledAppointmentUseCase})
    : super(const CancelledAppointmentsState());

  Future<void> fetchCancelledAppointments({bool loadMore = false}) async {
    // final parameters = _buildPaginationParameters(
    //   lastDocument: loadMore ? state.upcomingLastDocument : null,
    //   limit: 10,
    // );
    // final result = await cancelledAppointmentUseCase.call(parameters);
    // result.fold(
    //   (failure) => emit(
    //     state.copyWith(
    //       requestState: RequestState.error,
    //       failureMessage: failure.toString(),
    //     ),
    //   ),
    //   (response) {
    //     final appointments = loadMore
    //         ? [...state.upcomingAppointments, ...response.appointments]
    //         : response.appointments;
    //     emit(
    //       state.copyWith(
    //         appointments: appointments,
    //         requestState: RequestState.loaded,
    //       ),
    //     );
    //   },
    // );
  }
  PaginationParameters _buildPaginationParameters({
    DocumentSnapshot? lastDocument,
    int limit = 10,
  }) {
    return PaginationParameters(
      lastDocument: lastDocument,
      limit: limit,
    );
  }
}
