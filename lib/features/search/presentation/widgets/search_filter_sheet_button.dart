import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/search_type.dart';
import 'package:medora/core/extensions/context_extension.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:medora/features/search/presentation/controller/states/search_states.dart';
import 'package:medora/features/search/presentation/widgets/filter_sheet_content.dart';
import 'package:medora/features/search/presentation/widgets/shared/criteria_filter_icon.dart';

class SearchFilterSheetButton extends StatelessWidget {
  const SearchFilterSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchStates, SearchType>(
      selector: (state) => state.searchType,
      builder: (context, searchType) => CriteriaFilterIcon(
        isSearchingByCriteria: searchType == SearchType.byCriteria,
        onPressed: () => _showFilterSheet(context),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    context.ensureKeyboardIsClosed();
    _synchronizeFilters(context);
    _showSheet(context);
  }

  void _synchronizeFilters(BuildContext context) =>
      context.read<SearchCubit>().synchronizeDraftFiltersWithConfirmed();

  void _showSheet(BuildContext context) => AppAlerts.showLeftSheet(
    onCancelPressed: () => context.pop(),
    context: context,
    appBarBackgroundColor: AppColors.white,
    appBarTitle: AppStrings.filterSearch,
    appBarTitleColor: AppColors.black,
    body: BlocProvider.value(
      value: context.read<SearchCubit>(),

      child: const FilterSheetContent(),
    ),
  );
}
