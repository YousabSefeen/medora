import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector, ReadContext;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/price_input_field.dart' show PriceInputField;


class ManualPriceInputFields extends StatelessWidget {
  const ManualPriceInputFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 50,
      children: [
        Expanded(child: _buildMinPriceField(cubit)),

        Expanded(child: _buildMaxPriceField(cubit)),
      ],
    );
  }

  Widget _buildMinPriceField(SearchCubit cubit) {
    return BlocSelector<SearchCubit, SearchStates, double>(
      selector: (state) => state.priceRange.start,
      builder: (context, minPrice) {
        return SizedBox(
          height: 40,
          child: PriceInputField(
            label: 'Minimum',
            value: minPrice,
            isMinPrice: true,
            onValueChanged: cubit.updateMinPriceField,
          ),
        );
      },
    );
  }

  Widget _buildMaxPriceField(SearchCubit cubit) {
    return BlocSelector<SearchCubit, SearchStates, double>(
      selector: (state) => state.priceRange.end,
      builder: (context, maxPrice) {
        return SizedBox(
          height: 40,
          child: PriceInputField(
            label: 'Maximum',
            value: maxPrice,
            isMinPrice: false,
            onValueChanged: cubit.updateMaxPriceField,
          ),
        );
      },
    );
  }
}
