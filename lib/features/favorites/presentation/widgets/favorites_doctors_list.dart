import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesState;
import 'package:medora/features/favorites/presentation/widgets/favorites_empty_list.dart'
    show FavoritesEmptyList;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/screens/sliver_pagination_screen_mixin.dart'
    show SliverPaginationScreenMixin;
import 'package:medora/features/shared/presentation/widgets/doctor_card.dart'
    show DoctorCard;

class FavoritesDoctorsList extends StatefulWidget {
  final ScrollController scrollController;

  const FavoritesDoctorsList({super.key, required this.scrollController});

  @override
  State<FavoritesDoctorsList> createState() => _FavoritesDoctorsListState();
}

class _FavoritesDoctorsListState extends State<FavoritesDoctorsList>
    with
        SliverPaginationScreenMixin<
          DoctorEntity,
          FavoritesState,
          FavoritesCubit,

          FavoritesDoctorsList
        > {
  @override
  void initState() {
    // Connecting the external controller (Important: before super.initState())
    attachScrollController(widget.scrollController);
    super.initState();
  }

  @override
  Widget buildEmptyWidget() => const FavoritesEmptyList();

  @override
  Widget buildDataCard(DoctorEntity doctor, int index) =>
      DoctorCard(doctor: doctor);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) =>
          previous.isLoadingMore != current.isLoadingMore ||
          previous.requestState != current.requestState ||
          previous.favoriteIds != current.favoriteIds,
      builder: (context, state) => buildPaginationBody(context, state),
    );
  }
}
