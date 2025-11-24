import 'package:flutter/material.dart';
import 'package:medora/features/favorites/presentation/widgets/favorites_doctors_list.dart'
    show FavoritesDoctorsList;
import 'package:medora/features/home/presentation/widgets/home_screen_padding.dart'
    show HomeScreenPadding;

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenPadding(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [FavoritesDoctorsList()],
      ),
    );
  }
}
