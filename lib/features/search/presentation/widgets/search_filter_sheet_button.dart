import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    show KeyboardVisibilityBuilder;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/search_type.dart' show SearchType;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;
import 'package:medora/features/search/presentation/widgets/filter_sheet_content.dart'
    show FilterSheetContent;
import 'package:medora/features/search/presentation/widgets/shared/criteria_filter_icon.dart'
    show CriteriaFilterIcon;

class SearchFilterSheetButton extends StatelessWidget {
  const SearchFilterSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) =>
          BlocSelector<SearchCubit, SearchStates, SearchType>(
            selector: (state) => state.searchType,
            builder: (context, searchType) => CriteriaFilterIcon(
              isSearchingByCriteria: searchType == SearchType.byCriteria,
              onPressed: () {
                if (isKeyboardVisible) {
                  _dismissKeyboardThenShowFilterBottomSheet(context);
                } else {
                  _showFilterSheet(context);
                }
              },
            ),
          ),
    );
  }

  void _dismissKeyboardThenShowFilterBottomSheet(BuildContext context) {
    AppRouter.dismissKeyboard();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!context.mounted) return;
      _showFilterSheet(context);
    });
  }

  void _showFilterSheet(BuildContext context) {
    _synchronizeFilters(context);
    _showSheet(context);
  }

  void _synchronizeFilters(BuildContext context) =>
      context.read<SearchCubit>().synchronizeDraftFiltersWithConfirmed();

  void _showSheet(BuildContext context) => AppAlerts.showLeftSheet(
    onCancelPressed: () => Navigator.of(context).pop(),
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
