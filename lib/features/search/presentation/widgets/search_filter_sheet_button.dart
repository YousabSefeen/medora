import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    show KeyboardVisibilityBuilder;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
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
              isSearchingByCriteria: searchType==SearchType.byCriteria,
              onPressed: () {
                if (isKeyboardVisible) {
                  _dismissKeyboardThenShowFilterBottomSheet(context);
                } else {
                  _showFilterBottomSheet(context);
                }
              },
            ),
          ),
    );
  }

  void _dismissKeyboardThenShowFilterBottomSheet(BuildContext context) {
    AppRouter.dismissKeyboard();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!context.mounted) return;
      _showFilterBottomSheet(context);
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    
    context.read<SearchCubit>().synchronizeDraftFiltersWithConfirmed();
    AppAlerts.showLeftSheet(
      onCancelPressed: () => Navigator.of(context).pop(),
      context: context,
      appBarBackgroundColor: AppColors.white,
      appBarTitle: 'Filter Search',
      appBarTitleColor: AppColors.black,
      body: const FilterSheetContent(),
    );
  }
}
