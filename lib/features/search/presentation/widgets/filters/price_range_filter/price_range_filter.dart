import 'package:flutter/material.dart';
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/average_price_info.dart'
    show AveragePriceInfo;
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/manual_price_input_fields.dart'
    show ManualPriceInputFields;
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/price_display_widget.dart'
    show PriceDisplayWidget;
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/price_range_slider.dart'
    show PriceRangeSlider;

class PriceRangeFilter extends StatelessWidget {
  const PriceRangeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PriceDisplayWidget(),

        AveragePriceInfo(),

        PriceRangeSlider(),
        SizedBox(height: 12),
        ManualPriceInputFields(),
      ],
    );
  }
}
