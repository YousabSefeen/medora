import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/common_widgets/content_unavailable_widget.dart'
    show ContentUnavailableWidget;
import 'package:medora/core/constants/common_widgets/error_retry_widget.dart'
    show ErrorRetryWidget;
import 'package:medora/core/constants/common_widgets/sliver_loading%20_list.dart'
    show SliverLoadingList;
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/doctor_list_view.dart'
    show DoctorListView;

class FavoritesDoctorsList extends StatefulWidget {
  const FavoritesDoctorsList({super.key});

  @override
  State<FavoritesDoctorsList> createState() => _FavoritesDoctorsListState();
}

class _FavoritesDoctorsListState extends State<FavoritesDoctorsList> {
  @override
  initState() {
    _getAllFavoritesDoctors();
    super.initState();
  }

  static bool _isFavoritesLoadedBefore = false;

  Future<void> _getAllFavoritesDoctors() async {
    if (!_isFavoritesLoadedBefore) {
      await _loadFavoritesDoctors();
    }
    _isFavoritesLoadedBefore = true;
  }

  Future<void> _loadFavoritesDoctors() async =>
      await context.read<FavoritesCubit>().getFavoritesDoctors();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesStates>(
      builder: (context, state) {
        switch (state.favoritesListState) {
          case LazyRequestState.lazy:
          case LazyRequestState.loading:
            return const SliverLoadingList(height: 150);
          case LazyRequestState.loaded:
            return _buildFavoritesContent(state);

          case LazyRequestState.error:
            return ErrorRetryWidget(
              errorMessage: state.favoritesListError,
              retryButtonText: AppStrings.reloadFavorites,

              onRetry: () async => await _loadFavoritesDoctors(),
            );
        }
      },
    );
  }

  Widget _buildFavoritesContent(FavoritesStates state) {
    if (state.favoritesDoctorsList.isEmpty) {
      return _buildEmptyFavoritesView();
    } else {
      return _buildFavoritesListView(state.favoritesDoctorsList);
    }
  }

  Widget _buildEmptyFavoritesView() => const SliverFillRemaining(
    hasScrollBody: false,
    child: ContentUnavailableWidget(
      description: AppStrings.noFavoritesDoctorsFoundMessage,
    ),
  );

  Widget _buildFavoritesListView(List<DoctorEntity> doctors) =>
      DoctorListView(doctorList: doctors);
}
