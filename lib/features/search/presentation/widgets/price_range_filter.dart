import 'package:flutter/material.dart';
import 'package:medora/features/search/presentation/widgets/price_range/average_price_info.dart';
import 'package:medora/features/search/presentation/widgets/price_range/manual_price_input_fields.dart';
import 'package:medora/features/search/presentation/widgets/price_range/price_display_widget.dart';
import 'package:medora/features/search/presentation/widgets/price_range/price_range_slider.dart';

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
