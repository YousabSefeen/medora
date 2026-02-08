import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;
import 'package:medora/core/constants/common_widgets/error_retry_widget.dart'
    show ErrorRetryWidget;
import 'package:medora/core/constants/common_widgets/sliver_loading%20_list.dart'
    show SliverLoadingList;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;
import 'package:medora/features/shared/presentation/controllers/state/base_pagination_state.dart'
    show BasePaginationState;
import 'package:medora/features/shared/presentation/widgets/pagination_footer_widget_.dart'
    show PaginationFooterWidget;

mixin SliverPaginationScreenMixin<
  E,
  S extends BasePaginationState<E>,
  C extends BasePaginationCubit<E, S>,
  T extends StatefulWidget
>
    on State<T> {
  late final ScrollController _scrollController;

  // Connecting the external controller (Important: before super.initState())
  void attachScrollController(ScrollController controller) {
    _scrollController = controller;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  @override
  void dispose() {
    _cleanupScrollListener();
    super.dispose();
  }

  void _cleanupScrollListener() {
    // We only remove the listener, we don't dispose of the controller because it's external
    _scrollController.removeListener(_scrollListener);
  }

  // Fetch data for the first time
  void _fetchInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<C>().fetchInitialList();
    });
  }

  void _scrollListener() {
    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent) {
      context.read<C>().loadMore();
    }
  }

  Widget buildDataCard(E item, int index);

  Widget buildInitialLoading() => const SliverLoadingList(height: 150);

  Widget buildErrorWidget(String message) => ErrorRetryWidget(
    errorMessage: message,
    onRetry: () => context.read<C>().fetchInitialList(),
  );

  Widget buildEmptyWidget() => const ContentUnavailableWidget(
    description: AppStrings.emptyUpcomingAppointmentsMessage,
  );

  // Logic for counting the number of items (List + Footer)
  int _calculateItemCount(S state) {
    int count = state.dataList.length;

    if (state.isLoadingMore || (!state.hasMore && state.dataList.isNotEmpty)) {
      count += 1; // Adding the footer element
    }

    return count;
  }

  String? noMoreDataMessage;

  Widget _buildPaginationFooter(S state) {
    return PaginationFooterWidget(
      noMoreDataMessage: noMoreDataMessage ?? AppStrings.doctorsEndMessage,
      isLoadingMore: state.isLoadingMore,
      hasMore: state.hasMore,
      doctorsList: state.dataList,
    );
  }

  /// ========== Main function for building the interface ==========

  // Building the pagination body (called in build())
  Widget buildPaginationBody(BuildContext context, S state) {
    if (state.requestState == RequestState.loading && state.dataList.isEmpty) {
      return buildInitialLoading();
    }

    if (state.requestState == RequestState.error && state.dataList.isEmpty) {
      return buildErrorWidget(state.failureMessage);
    }

    if (state.requestState == RequestState.loaded && state.dataList.isEmpty) {
      return buildEmptyWidget();
    }

    return SliverList.builder(
      itemCount: _calculateItemCount(state),
      itemBuilder: (context, index) {
        // إذا كان الفهرس يشير إلى عنصر الـ footer
        if (index >= state.dataList.length) {
          return _buildPaginationFooter(state);
        }

        // عرض عنصر البيانات
        return buildDataCard(state.dataList[index], index);
      },
    );
  }
}
