import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/di/injection_container.dart';
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart';
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart';
import 'package:medora/features/search/presentation/widgets/search_app_bar_section.dart';
import 'package:medora/features/search/presentation/widgets/search_content_section.dart';

import '../../../shared/presentation/widgets/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create SearchCubit directly to ensure screen-level state isolation
    // and prevent shared instance issues with bottom sheets
    return BlocProvider(
      create: (_) => SearchCubit(searchByName: sl(), searchByCriteria: sl()),
      child: HomeScreenPadding(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomAppBar.sliver(title: AppStrings.search, context: context),
            const SearchAppBarSection(),
            const SearchContentSection(),
          ],
        ),
      ),
    );
  }
}
