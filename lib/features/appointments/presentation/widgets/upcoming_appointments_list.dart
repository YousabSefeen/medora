import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/error_retry_widget.dart'
    show ErrorRetryWidget;
import 'package:medora/core/constants/common_widgets/loading_list.dart'
    show LoadingList;
import 'package:medora/core/enum/request_state.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/upcoming_appointments_state.dart'
    show UpcomingAppointmentsState;
import 'package:medora/features/shared/presentation/widgets/pagination_footer_widget_.dart'
    show PaginationFooterWidget;

import '../../../../core/enum/appointment_status.dart';
import '../screens/appointment_details_screen.dart';
import 'appointment_card.dart';

class UpcomingAppointmentsList extends StatefulWidget {
  const UpcomingAppointmentsList({super.key});

  @override
  State<UpcomingAppointmentsList> createState() =>
      _UpcomingAppointmentsListState();
}

class _UpcomingAppointmentsListState extends State<UpcomingAppointmentsList> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    context.read<UpcomingAppointmentsCubit>().fetchUpcomingAppointmentsList();

    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  void _scrollListener() {
    // Call loadMoreDoctors when 95% of the end is reached
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      context.read<UpcomingAppointmentsCubit>().loadMoreAppointments();
    }
  }

  int _calculateItemCount(UpcomingAppointmentsState state) {
    int count = state.appointments.length;

    if (state.isLoadingMore ||
        (!state.hasMore && state.appointments.isNotEmpty)) {
      count += 1;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingAppointmentsCubit, UpcomingAppointmentsState>(
      builder: (context, state) {
        if (state.requestState == RequestState.loading &&
            state.appointments.isEmpty) {
          return const LoadingList(height: 150);
        }

        if (state.requestState == RequestState.error &&
            state.appointments.isEmpty) {
          return _buildErrorRetryWidget(state.failureMessage);
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: _calculateItemCount(state),

          itemBuilder: (context, index) =>
              _buildListItem(context, index, state),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context,
    int index,
    UpcomingAppointmentsState state,
  ) {
    // Check if we are at the end of the list to display the Footer widget
    if (index >= state.appointments.length) {
      return _buildFooterWidget(state);
    }

    // Displaying the regular doctor item

    return _buildAppointmentCard(state.appointments[index]);
  }

  Widget _buildFooterWidget(UpcomingAppointmentsState state) {
    return PaginationFooterWidget(
      isLoadingMore: state.isLoadingMore,
      hasMore: state.hasMore,
      doctorsList: state.appointments,
    );
  }

  Widget _buildErrorRetryWidget(String failureMessage) => ErrorRetryWidget(
    errorMessage: failureMessage,
    retryButtonText: AppStrings.reloadDoctors,
    onRetry: () async => await context
        .read<UpcomingAppointmentsCubit>()
        .fetchUpcomingAppointmentsList(),
  );

  Widget _buildAppointmentCard(ClientAppointmentsEntity appointment) {
    return GestureDetector(
      onTap: () => _navigateToAppointmentDetails(context, appointment),

      child: AppointmentCard(
        appointmentStatus: AppointmentStatus.confirmed,
        appointment: appointment,
      ),
    );
  }

  void _navigateToAppointmentDetails(
    BuildContext context,
    ClientAppointmentsEntity appointment,
  ) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) =>
          AppointmentDetailsScreen(appointment: appointment),
    ),
  );
}
