import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/widgets/filter_action_button.dart'
    show FilterActionButton;

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterActionButton(
      text: 'Reset',
      backgroundColor: AppColors.red,
      onPressed: () => context.read<SearchCubit>().resetFilters(),
    );
  }
}
