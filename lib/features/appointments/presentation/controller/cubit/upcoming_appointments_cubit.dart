import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:hydrated_bloc/hydrated_bloc.dart' show Cubit;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/data/models/paginated_appointments_response.dart';
import 'package:medora/features/appointments/domain/use_cases/fetch_upcoming_appointment_use_case.dart'
    show FetchUpcomingAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

class UpcomingAppointmentsCubit extends Cubit<UpcomingAppointmentsState> {
  final FetchUpcomingAppointmentUseCase upcomingAppointmentsUseCase;

  UpcomingAppointmentsCubit({required this.upcomingAppointmentsUseCase})
    : super(const UpcomingAppointmentsState());

  Future<void> fetchUpcomingAppointments({bool loadMore = false}) async {
    final parameters = _buildPaginationParameters(
      lastDocument: loadMore ? state.upcomingLastDocument : null,
      limit: 10,
    );
    final result = await upcomingAppointmentsUseCase.call(parameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          requestState: RequestState.error,
          failureMessage: failure.toString(),
        ),
      ),
      (PaginatedAppointmentsResponse response) {
        final appointments = loadMore
            ? [...state.upcomingAppointments, ...response.appointments]
            : response.appointments;
        emit(
          state.copyWith(
            appointments: appointments,
            requestState: RequestState.loaded,
            upcomingLastDocument: response.lastDocument,
          ),
        );
      },
    );
  }

  PaginationParameters _buildPaginationParameters({
    DocumentSnapshot? lastDocument,
    int limit = 10,
  }) {
    return PaginationParameters(lastDocument: lastDocument, limit: limit);
  }
}
