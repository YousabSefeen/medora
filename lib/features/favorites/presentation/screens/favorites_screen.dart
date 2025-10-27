import 'package:flutter/material.dart';
import 'package:medora/features/favorites/presentation/widgets/favorites_doctors_list.dart'
    show FavoritesDoctorsList;

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [FavoritesDoctorsList()],
    );
  }
}
