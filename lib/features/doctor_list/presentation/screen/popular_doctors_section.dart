import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/common_widgets/error_retry_widget.dart'
    show ErrorRetryWidget;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/shared/presentation/widgets/doctor_card.dart'
    show DoctorCard;
import 'package:medora/features/shared/presentation/widgets/pagination_footer_widget_.dart'
    show PaginationFooterWidget;

import '../../../../core/constants/common_widgets/sliver_loading _list.dart'
    show SliverLoadingList;
import '../controller/cubit/doctor_list_cubit.dart';
import '../controller/states/doctor_list_state.dart';

class PopularDoctorsSection extends StatefulWidget {
  final ScrollController scrollController;

  const PopularDoctorsSection({super.key, required this.scrollController});

  @override
  State<PopularDoctorsSection> createState() => _PopularDoctorsSectionState();
}

class _PopularDoctorsSectionState extends State<PopularDoctorsSection> {
  @override
  void initState() {
    context.read<DoctorListCubit>().getDoctorsList();

    widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  void _scrollListener() {
    // Call loadMoreDoctors when 95% of the end is reached
    if (widget.scrollController.position.pixels >=
        widget.scrollController.position.maxScrollExtent) {
      context.read<DoctorListCubit>().loadMoreDoctors();
    }
  }

  /// 🎯 Calculates the total number of slots required by the SliverList.builder.
  ///
  /// The returned count is composed of two parts:
  /// 1. The **actual number of doctors** ([state.doctorList.length]).
  /// 2. **One additional slot (+1)** reserved exclusively for the functional footer widget,
  ///    which displays either the **loading indicator** (during [isLoadingMore]) or
  ///    the **"No more data" message** (when [hasMore] is false).
  ///
  /// This ensures the item builder has an index to draw the footer when needed.
  ///
  /// @param state The current state of the DoctorListCubit.
  /// @returns The final count for the SliverList.builder item count.
  int _calculateItemCount(DoctorListState state) {
    int count = state.doctorList.length;

    if (state.isLoadingMore ||
        (!state.hasMore && state.doctorList.isNotEmpty)) {
      count += 1;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorListCubit, DoctorListState>(
      builder: (context, state) {
        if (state.doctorListState == RequestState.loading &&
            state.doctorList.isEmpty) {
          return const SliverLoadingList(height: 150);
        }

        if (state.doctorListState == RequestState.error &&
            state.doctorList.isEmpty) {
          return _buildErrorRetryWidget(state);
        }

        return SliverList.builder(
          itemCount: _calculateItemCount(state),

          itemBuilder: (context, index) =>
              _buildListItem(context, index, state),
        );
      },
    );
  }

  Widget _buildErrorRetryWidget(DoctorListState state) {
    return SliverToBoxAdapter(
      child: ErrorRetryWidget(
        errorMessage: state.doctorListError,
        retryButtonText: AppStrings.reloadDoctors,
        onRetry: () async =>
            await context.read<DoctorListCubit>().getDoctorsList(),
      ),
    );
  }

  Widget _buildFooterWidget(DoctorListState state) {
    return PaginationFooterWidget(
      isLoadingMore: state.isLoadingMore,
      hasMore: state.hasMore,
      doctorsList: state.doctorList,
    );
  }

  Widget _buildListItem(
    BuildContext context,
    int index,
    DoctorListState state,
  ) {
    // Check if we are at the end of the list to display the Footer widget
    if (index >= state.doctorList.length) {
      return _buildFooterWidget(state);
    }

    // Displaying the regular doctor item

    return DoctorCard(doctor: state.doctorList[index]);
  }
}
