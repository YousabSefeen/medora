import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/common_widgets/sliver_loading%20_list.dart'
    show SliverLoadingList;
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/doctor_list/presentation/widgets/doctor_list_view.dart'
    show DoctorListView;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit_new.dart' show FavoritesCubitNew;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states_new.dart' show FavoritesStatesNew;

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
      await context.read<FavoritesCubitNew>().getFavorites();
    }
    _isFavoritesLoadedBefore = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubitNew, FavoritesStatesNew>(
      builder: (context, state) {
        switch (state.favoritesListState) {
          case LazyRequestState.lazy:
          case LazyRequestState.loading:
            return const SliverLoadingList(height: 150);
          case LazyRequestState.loaded:
            return DoctorListView(doctorList: state.favoritesList);
          case LazyRequestState.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.favoritesListError,
                  style: const TextStyle(fontSize: 30, color: Colors.red),
                ),
              ),
            );
        }
      },
    );
  }
}
