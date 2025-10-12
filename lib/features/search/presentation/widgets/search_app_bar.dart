import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/search/presentation/widgets/apply_button.dart' show ApplyButton;
import 'package:medora/features/search/presentation/widgets/filter_button.dart';
import 'package:medora/features/search/presentation/widgets/filters/location_filter/location_filter_field.dart'
    show LocationFilterField;
import 'package:medora/features/search/presentation/widgets/filters/price_range_filter/price_range_filter.dart'
    show PriceRangeFilter;
import 'package:medora/features/search/presentation/widgets/filters/specialities_filter/specialties_filter_grid.dart'
    show SpecialtiesFilterGrid;
import 'package:medora/features/search/presentation/widgets/search_text_field.dart';

class SearchAppBarSection extends StatefulWidget {
  const SearchAppBarSection({super.key});

  @override
  State<SearchAppBarSection> createState() => _SearchAppBarSectionState();
}

class _SearchAppBarSectionState extends State<SearchAppBarSection> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 16),
            _buildSearchRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Let\'s Find Your\nDoctor',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: 1,
        wordSpacing: 5,
      ),
    );
  }

  Widget _buildSearchRow(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SearchTextField()),
        const SizedBox(width: 12),
        FilterButton(onPressed: () => _showFilterBottomSheet(context)),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    AppAlerts.showCustomBottomSheet(
      shouldShowScrollbar: false,
      context: context,
      appBarBackgroundColor: AppColors.softBlue,
      appBarTitle: 'Filter Search',
      appBarTitleColor: AppColors.white,
      body: const FilterBottomSheetContent(),
    );
  }
}

class FilterBottomSheetContent extends StatelessWidget {
  const FilterBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 15),
      color: AppColors.softBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: PriceRangeFilter(),
          ),
          _buildFilterSectionTitle(context, 'Specialties'),

          const SpecialtiesFilterGrid(),

          _buildFilterSectionTitle(context, 'Location'),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: LocationFilterField(),
          ),
          const SizedBox(height: 20),
          const ApplyButton(),
        ],
      ),
    );
  }

  Padding _buildFilterSectionTitle(BuildContext context, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 30),
      child: Text(title, style: Theme.of(context).textTheme.caladeaWhite),
    );
}
