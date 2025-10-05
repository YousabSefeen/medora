import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/features/search/presentation/widgets/filter_button.dart';
import 'package:medora/features/search/presentation/widgets/location_filter_field.dart'
    show LocationFilterField;
import 'package:medora/features/search/presentation/widgets/search_text_field.dart';
import 'package:medora/features/search/presentation/widgets/specialties_filter_grid.dart'
    show SpecialtiesFilterGrid;

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
    return Text(
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
        Expanded(child: SearchTextField()),
        const SizedBox(width: 12),
        FilterButton(onPressed: () => _showFilterBottomSheet(context)),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    AppAlerts.showCustomBottomSheet(
      shouldShowScrollbar: false,
      context: context,
      appBarBackgroundColor: Colors.white,
      appBarTitle: 'Filters',
      appBarTitleColor: Colors.black,
      body: const FilterBottomSheetContent(),
    );
  }
}

class FilterBottomSheetContent extends StatelessWidget {
  const FilterBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(15, 50, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterSectionTitle(title: 'Specialties'),
          SizedBox(height: 12),
          SpecialtiesFilterGrid(),
          SizedBox(height: 24),
          FilterSectionTitle(title: 'Location'),
          SizedBox(height: 12),
          LocationFilterField(),
        ],
      ),
    );
  }
}

class FilterSectionTitle extends StatelessWidget {
  final String title;

  const FilterSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }
}
