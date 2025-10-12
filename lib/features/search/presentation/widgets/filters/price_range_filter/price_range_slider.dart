import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector, ReadContext;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;

class PriceRangeSlider extends StatelessWidget {
  const PriceRangeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchStates, RangeValues>(
      selector: (state) => state.priceRange,
      builder: (context, priceRangeSlider) => RangeSlider(
        values: priceRangeSlider,
        min: 50,
        max: 1500,
        divisions: 29,
        labels: RangeLabels(
          priceRangeSlider.start.round().toString(),
          priceRangeSlider.end.round().toString(),
        ),
        onChanged: (RangeValues newRangeValues) =>
            context.read<SearchCubit>().updatePriceSlider(newRangeValues),
      ),
    );
  }
}
