import 'package:flutter/material.dart';
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart'
    show HomeScreenPadding;
import 'package:medora/features/search/presentation/widgets/search_app_bar_section.dart'
    show SearchAppBarSection;
import 'package:medora/features/search/presentation/widgets/search_content_section.dart'
    show SearchContentSection;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenPadding(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [SearchAppBarSection(), SearchContentSection()],
      ),
    );
  }
}
