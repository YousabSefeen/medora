import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector, ReadContext;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;
import 'package:medora/features/search/presentation/widgets/filters/specialities_filter/specialty_item_content.dart'
    show SpecialtyItemContent;

class SpecialtyItem extends StatelessWidget {
  final String specialty;

  const SpecialtyItem({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchStates, bool>(
      selector: _specialtySelectionSelector,
      builder: (context, isSelected) {
        return SpecialtyItemContent(
          specialty: specialty,
          isSelected: isSelected,
          onTap: () => context.read<SearchCubit>().toggleSpecialty(specialty),
        );
      },
    );
  }

  bool _specialtySelectionSelector(SearchStates state) =>
      state.draftSelectedSpecialties.contains(specialty);
}
