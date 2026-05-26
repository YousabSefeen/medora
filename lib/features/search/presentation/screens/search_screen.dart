import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/di/injection_container.dart' show sl;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart'
    show HomeScreenPadding;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/widgets/search_app_bar_section.dart'
    show SearchAppBarSection;
import 'package:medora/features/search/presentation/widgets/search_content_section.dart'
    show SearchContentSection;

import 'package:medora/features/shared/presentation/widgets/page_sliver_header.dart' show PageSliverHeader;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create SearchCubit directly to ensure screen-level state isolation
    // and prevent shared instance issues with bottom sheets
    return BlocProvider(
      create: (_) => SearchCubit(
        searchByName: sl(),
        searchByCriteria: sl(),
      ),
      child: const HomeScreenPadding(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            PageSliverHeader(title: AppStrings.search),
            SearchAppBarSection(),
            SearchContentSection(),
          ],
        ),
      ),
    );
  }
}
