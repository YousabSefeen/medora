import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/features/favorites/presentation/widgets/favorites_doctors_list.dart'
    show FavoritesDoctorsList;
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart'
    show HomeScreenPadding;
import 'package:medora/features/shared/presentation/widgets/page_sliver_header.dart'
    show PageSliverHeader;

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
          const PageSliverHeader(title: AppStrings.myFavoriteDoctors),
          FavoritesDoctorsList(scrollController: _scrollController),
        ],
      ),
    );
  }
}
