// core/utils/pagination/pagination_screen_mixin.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;
import 'package:medora/core/constants/common_widgets/error_retry_widget.dart'
    show ErrorRetryWidget;
import 'package:medora/core/constants/common_widgets/loading_list.dart'
    show LoadingList;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/shared/presentation/controllers/cubit/base_pagination_cubit.dart'
    show BasePaginationCubit;
import 'package:medora/features/shared/presentation/controllers/state/base_pagination_state.dart'
    show BasePaginationState;
import 'package:medora/features/shared/presentation/widgets/pagination_footer_widget_.dart'
    show PaginationFooterWidget;

mixin PaginationScreenMixin<
  E,
  S extends BasePaginationState<E>,
  C extends BasePaginationCubit<E, S>,
  T extends StatefulWidget
>
    on State<T> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);

    // جلب البيانات لأول مرة
    context.read<C>().fetchInitialList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      context.read<C>().loadMore();
    }
  }

  // دالة لبناء الكارت (يجب تنفيذها في الشاشة)
  Widget buildDataCard(E item);

  // دالة لبناء الـ Loading (يمكن عمل Override لها إذا أردت شكل مختلف)
  Widget buildInitialLoading() => const LoadingList(height: 150);

  // دالة لبناء الخطأ
  Widget buildErrorWidget(String message) => ErrorRetryWidget(
    isSliverWidget: false,
    errorMessage: message,

    onRetry: () => context.read<C>().fetchInitialList(),
  );

  // منطق حساب عدد العناصر (القائمة + الـ Footer)
  int _calculateItemCount(S state) {
    int count = state.dataList.length;
    if (state.isLoadingMore || (!state.hasMore && state.dataList.isNotEmpty)) {
      count += 1;
    }
    return count;
  }

  // الهيكل الرئيسي للقائمة (يتم استدعاؤه في الـ build الخاص بالشاشة)
  Widget buildPaginationBody(BuildContext context, S state) {
    if (state.requestState == RequestState.loading && state.dataList.isEmpty) {
      return buildInitialLoading();
    }

    if (state.requestState == RequestState.error && state.dataList.isEmpty) {
      return buildErrorWidget(state.failureMessage);
    }
    if (state.requestState == RequestState.loaded && state.dataList.isEmpty) {
      return const ContentUnavailableWidget(
        description: AppStrings.emptyUpcomingAppointmentsMessage,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      controller: scrollController,
      itemCount: _calculateItemCount(state),
      itemBuilder: (context, index) {
        if (index >= state.dataList.length) {
          return PaginationFooterWidget(
            isLoadingMore: state.isLoadingMore,
            hasMore: state.hasMore,
            doctorsList: state.dataList,
          );
        }
        return buildDataCard(state.dataList[index]);
      },
    );
  }
}
