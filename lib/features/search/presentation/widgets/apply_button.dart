import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;


import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:medora/features/search/presentation/widgets/filter_action_button.dart'
    show FilterActionButton;

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterActionButton(
      text: 'Apply',
      backgroundColor:AppColors.softBlue,
      onPressed: () {
        Navigator.of(context).pop();

        Future.delayed(
          const Duration(milliseconds: 500),
          () => !context.mounted
              ? null
              : context.read<SearchCubit>().searchDoctorsByCriteria(),
        );
      },
    );

  }


}
