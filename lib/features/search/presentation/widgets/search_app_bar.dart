import 'package:flutter/material.dart';

import 'package:medora/features/search/presentation/widgets/filter_button.dart' show FilterButton;


import 'package:medora/features/search/presentation/widgets/search_text_field.dart';

class SearchAppBarSection extends StatelessWidget {
  const SearchAppBarSection({super.key});

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
    return const Row(
      children: [

        Expanded(child: SearchTextField()),
        SizedBox(width: 12),
        FilterButton(),
      ],
    );
  }


}


