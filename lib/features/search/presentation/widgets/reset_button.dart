import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/search_type.dart' show SearchType;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/widgets/filter_action_button.dart'
    show FilterActionButton;

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterActionButton(
      text: AppStrings.reset,
      backgroundColor: AppColors.red,
      onPressed: () => _navigateBackWithCriteriaSearch(context),
    );
  }

  void _navigateBackWithCriteriaSearch(BuildContext context) {
    Navigator.of(context).pop();
    context.read<SearchCubit>().updateSearchType(SearchType.byName);
  }
}
