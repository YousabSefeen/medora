import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:medora/features/search/presentation/widgets/search_filter_sheet_button.dart'
    show SearchFilterSheetButton;


import 'package:medora/features/search/presentation/widgets/search_text_field.dart';

class SearchAppBarSection extends StatelessWidget {
  const SearchAppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing:10,
          children: [
            _buildTitle(),

            _buildSearchRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return   Text(
      'Let\'s Find Your\nDoctor',
      style: GoogleFonts.caladea(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height:1.4,
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
        SearchFilterSheetButton(),
      ],
    );
  }


}


