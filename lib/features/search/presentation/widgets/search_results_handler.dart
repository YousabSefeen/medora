import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocSelector, ReadContext;
import 'package:medora/core/constants/common_widgets/error_retry_widget.dart'
    show ErrorRetryWidget;
import 'package:medora/core/constants/common_widgets/sliver_loading%20_list.dart'
    show SliverLoadingList;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/doctor_list/presentation/widgets/doctor_list_view.dart'
    show DoctorListView;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart';
import 'package:medora/features/search/presentation/widgets/search_welcome_widget.dart'
    show SearchWelcomeWidget;
import 'package:medora/features/shared/presentation/widgets/empty_search_list_results.dart' show EmptySearchListResult;


class SearchResultsHandler extends StatelessWidget {
  const SearchResultsHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, searchState) =>
          _buildSearchResults(searchState, context),
    );
  }

  Widget _buildSearchResults(SearchStates state, BuildContext context) {
    switch (state.searchResultsState) {
      case LazyRequestState.lazy:
        return const SearchWelcomeWidget();
      case LazyRequestState.loading:
        return const SliverLoadingList(height: 150);
      case LazyRequestState.loaded:
        return state.searchResults.isEmpty
            ? _buildEmptySearchResult()
            : DoctorListView(doctorList: state.searchResults);
      case LazyRequestState.error:
        return _buildErrorState(state, context);
    }
  }

  SliverFillRemaining _buildEmptySearchResult() => SliverFillRemaining(
    hasScrollBody: false,

    child: BlocSelector<SearchCubit, SearchStates, String?>(
      selector: (state) => state.doctorName,
      builder: (context, doctorName) {
        final isDoctorNameEmpty = doctorName == '';

        return !isDoctorNameEmpty
            ? const SizedBox()
            : const EmptySearchListResult();
      },
    ),
  );

  Widget _buildErrorState(SearchStates state, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SliverPadding(
      padding: EdgeInsets.only(top: screenHeight * 0.15),
      sliver: ErrorRetryWidget(
        errorMessage: state.searchResultsErrorMsg,

        onRetry: () => context.read<SearchCubit>().updateDoctorName(),
      ),
    );
  }
}
