import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:medora/core/constants/common_widgets/sliver_loading%20_list.dart'
    show SliverLoadingList;
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/doctor_list/presentation/widgets/doctor_list_view.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart';
import 'package:medora/features/search/presentation/widgets/no_matching_doctors_widget.dart';
import 'package:medora/features/search/presentation/widgets/search_welcome_widget.dart';

class SearchResultsHandler extends StatelessWidget {
  const SearchResultsHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, searchState) => _buildSearchResults(searchState),
    );
  }

  Widget _buildSearchResults(SearchStates state) {
    switch (state.searchResultsState) {
      case LazyRequestState.lazy:
        return const SearchWelcomeWidget();
      case LazyRequestState.loading:
        return const SliverLoadingList(height: 150);
      case LazyRequestState.loaded:
        return state.searchResults.isEmpty
            ? const NoMatchingDoctorsWidget()
            : DoctorListView(doctorList: state.searchResults);
      case LazyRequestState.error:
        return _buildErrorState(state);
    }
  }

  Widget _buildErrorState(SearchStates state) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Text(
          'Error loading search results', // TODO: Use actual error message
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }
}
