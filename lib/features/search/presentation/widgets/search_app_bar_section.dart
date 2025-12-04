import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/search/presentation/widgets/search_filter_sheet_button.dart'
    show SearchFilterSheetButton;
import 'package:medora/features/search/presentation/widgets/search_text_field.dart';

class SearchAppBarSection extends StatelessWidget {
  const SearchAppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [_buildTitle(context), _buildSearchRow(context)],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) => Text(
    AppStrings.searchScreenTitle,
    style: Theme.of(context).textTheme.searchScreenTitle,
  );

  Widget _buildSearchRow(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: SearchTextField()),
        SizedBox(width: 12),
        SearchFilterSheetButton(),
      ],
    );
  }
}
