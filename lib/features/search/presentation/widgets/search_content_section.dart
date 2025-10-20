import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;
import 'package:medora/features/search/presentation/widgets/search_results_handler.dart'
    show SearchResultsHandler;
import 'package:medora/features/search/presentation/widgets/search_welcome_widget.dart'
    show SearchWelcomeWidget;

class SearchContentSection extends StatelessWidget {
  const SearchContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchStates, String?>(
      selector: (state) => state.doctorName,
      builder: (context, doctorName) {
        return _buildContentBasedOnSearch(doctorName);
      },
    );
  }

  Widget _buildContentBasedOnSearch(String? doctorName) {
    if (_shouldShowWelcomeScreen(doctorName)) {
      return const SearchWelcomeWidget();
    } else {
      return const SearchResultsHandler();
    }
  }

  bool _shouldShowWelcomeScreen(String? doctorName) =>
      doctorName == null || doctorName.isEmpty;
}
