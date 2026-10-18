import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/features/favorites/presentation/widgets/favorites_doctors_list.dart';
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart';

import '../../../shared/presentation/widgets/custom_app_bar.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenPadding(
      child: CustomScrollView(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomAppBar.sliver(
            title: AppStrings.favoriteDoctors,
            context: context,
          ),
          FavoritesDoctorsList(scrollController: _scrollController),
        ],
      ),
    );
  }
}
