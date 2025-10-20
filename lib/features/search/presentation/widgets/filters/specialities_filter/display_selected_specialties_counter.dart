import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector;
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/animation_type.dart' show AnimationType;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;

class DisplaySelectedSpecialtiesCounter extends StatelessWidget {
  const DisplaySelectedSpecialtiesCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchStates, List<String>>(
      selector: (state) => state.draftSelectedSpecialties,
      builder: (context, selectedSpecialties) {
        final selectedSpecialtiesLength = selectedSpecialties.length;
        return CustomAnimationTransition(
          animationType: AnimationType.fade,
          child: Padding(
            key: ValueKey(selectedSpecialtiesLength),
            padding: const EdgeInsets.only(bottom: 10, top: 30),
            child: Visibility(
              visible: selectedSpecialtiesLength > 0,
              child: _selectedSpecialtiesLength(
                selectedSpecialtiesLength,
                context,
              ),
            ),
          ),
        );
      },
    );
  }

  Text _selectedSpecialtiesLength(
    int selectedSpecialtiesLength,
    BuildContext context,
  ) => Text(
      '( $selectedSpecialtiesLength )',
      style: Theme.of(context).textTheme.caladeaWhite,
    );
}
