import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart'
    show ClientAppointmentsEntity;
import 'package:medora/features/appointments/domain/use_cases/fetch_upcoming_appointment_use_case.dart'
    show FetchUpcomingAppointmentUseCase;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;
import 'package:medora/features/shared/domain/entities/paginated_data_response.dart'
    show PaginatedDataResponse;
import 'package:medora/features/shared/domain/entities/pagination_parameters.dart'
    show PaginationParameters;

import '../../../../../core/error/failure.dart' show Failure;

class UpcomingAppointmentsCubit extends Cubit<UpcomingAppointmentsState> {
  final FetchUpcomingAppointmentUseCase upcomingAppointmentsUseCase;

  UpcomingAppointmentsCubit({required this.upcomingAppointmentsUseCase})
    : super(const UpcomingAppointmentsState());

  //   1. Bringing the list for the first time
  Future<void> fetchUpcomingAppointmentsList() async {
    if (state.isLoadedBefore) {
      return;
    }
    await _fetchAppointments(isInitial: true);
    emit(state.copyWith(isLoadedBefore: true));
  }

  //2. Load more doctors (called via scroll listener)
  Future<void> loadMoreAppointments() async {

    // Verify that we are not currently in a loading state and that there is more data
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    Future.delayed(const Duration(seconds: 2), () async {
      await _fetchAppointments(isInitial: false);
    });
  }

  Future<void> _fetchAppointments({required bool isInitial}) async {
    final parameters = PaginationParameters(
      lastDocument: isInitial ? null : state.lastDocument,
      limit: 4,
    );

    final Either<Failure, PaginatedDataResponse> response =
        await upcomingAppointmentsUseCase.call(parameters);

    response.fold(
      (Failure failure) => _handleFailure(isInitial, failure),
      (PaginatedDataResponse paginatedDataResponse) =>
          _handleSuccess(paginatedDataResponse, isInitial),
    );
  }

  void _handleFailure(bool isInitial, Failure failure) => emit(
    state.copyWith(
      requestState: isInitial ? RequestState.error : state.requestState,
      failureMessage: failure.toString(),
      isLoadingMore: false,
    ),
  );

  void _handleSuccess(
    PaginatedDataResponse paginatedDataResponse,
    bool isInitial,
  ) {
    final List<ClientAppointmentsEntity> newAppointments =
        paginatedDataResponse.list as List<ClientAppointmentsEntity>;

    //  Merging lists
    final List<ClientAppointmentsEntity> updatedList = isInitial
        ? newAppointments // If the load is initial, use the new menu
        : state.appointments + newAppointments; // If more loads, add to current list

    emit(
      state.copyWith(
        appointments: updatedList,
        requestState: RequestState.loaded,
        // Store the last retrieved document
        lastDocument: paginatedDataResponse.lastDocument,
        // Update status: More available
        hasMore: paginatedDataResponse.hasMore,

        isLoadingMore: false,
      ),
    );
  }
}
