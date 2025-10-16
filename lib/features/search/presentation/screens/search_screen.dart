import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;
import 'package:medora/features/search/presentation/widgets/search_app_bar.dart'
    show SearchAppBarSection;
import 'package:medora/features/search/presentation/widgets/search_results_handler.dart'
    show SearchResultsHandler;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SearchAppBarSection(),
            SearchResultsHandler(searchState: state),
          ],
        );
      },
    );
  }
}
