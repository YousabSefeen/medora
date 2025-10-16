import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/search/presentation/widgets/apply_button.dart'
    show ApplyButton;
import 'package:medora/features/search/presentation/widgets/filter_section_title.dart'
    show FilterSectionTitle;
import 'package:medora/features/search/presentation/widgets/filters/location_filter/location_filter_field.dart'
    show LocationFilterField;
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/price_range_filter.dart'
    show PriceRangeFilter;
import 'package:medora/features/search/presentation/widgets/filters/specialities_filter/display_selected_specialties_counter.dart'
    show DisplaySelectedSpecialtiesCounter;
import 'package:medora/features/search/presentation/widgets/filters/specialities_filter/specialties_filter_grid.dart'
    show SpecialtiesFilterGrid;
import 'package:medora/features/search/presentation/widgets/reset_button.dart'
    show ResetButton;

class FilterSheetContent extends StatelessWidget {
  const FilterSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 15, bottom: 20),
      color: AppColors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: PriceRangeFilter(),
          ),
          Row(
            spacing: 5,
            children: [
              FilterSectionTitle(title: 'Specialties'),
              DisplaySelectedSpecialtiesCounter(),
            ],
          ),

          SpecialtiesFilterGrid(),

          FilterSectionTitle(title: 'Location'),

          Padding(
            padding: EdgeInsets.only(right: 15, bottom: 30),
            child: LocationFilterField(),
          ),
          ApplyButton(),
          SizedBox(height: 20),
          ResetButton(),
        ],
      ),
    );
  }
}
