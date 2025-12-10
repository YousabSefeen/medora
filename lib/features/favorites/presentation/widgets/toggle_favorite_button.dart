import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/animation_type.dart' show AnimationType;
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;

class ToggleFavoriteButton extends StatefulWidget {
  final DoctorModel doctorInfo;

  const ToggleFavoriteButton({super.key, required this.doctorInfo});

  @override
  State<ToggleFavoriteButton> createState() => _ToggleFavoriteButtonState();
}

class _ToggleFavoriteButtonState extends State<ToggleFavoriteButton> {
  @override
  void initState() {
    context.read<FavoritesCubit>().checkDoctorFavoriteStatus(
      doctorId: widget.doctorInfo.doctorId!,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
      listener: _handleFavoriteUpdateErrors,
      listenWhen: (previous, current) =>
          current.toggleFavoriteError != previous.toggleFavoriteError,

      buildWhen: (previous, current) =>
          current.favoriteDoctorsSet != previous.favoriteDoctorsSet,
      builder: (context, state) {
        bool isFav = _isFavoriteDoctor(state);
        switch (state.requestState) {
          case LazyRequestState.lazy:
          case LazyRequestState.loading:
          case LazyRequestState.error:
            return const SizedBox();
          case LazyRequestState.loaded:
            return _toggleFavoriteButton(isFav, context);
        }
      },
    );
  }

  bool _isFavoriteDoctor(FavoritesStates state) =>
      state.favoriteDoctorsSet.contains(widget.doctorInfo.doctorId);

  void _handleFavoriteUpdateErrors(
    BuildContext context,
    FavoritesStates state,
  ) {
    if (state.toggleFavoriteState == LazyRequestState.error) {
      AppAlerts.showTopSnackBarAlert(
        context: context,
        msg: state.toggleFavoriteError,
        backgroundColor: AppColors.red,
      );
    }
  }

  CustomAnimationTransition _toggleFavoriteButton(
    bool isFav,
    BuildContext context,
  ) => CustomAnimationTransition(
    animationType: AnimationType.fade,
    duration: AppDurations.milliseconds_600,
    child: IconButton(
      key: ValueKey(isFav),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      iconSize: 24,
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: isFav ? Colors.red : Colors.grey,
      ),

      onPressed: () async => await _toggleFavorite(context, isFav),
    ),
  );

  Future<void> _toggleFavorite(BuildContext context, bool isFav) async =>
      await context.read<FavoritesCubit>().toggleFavorite(
        isFavorite: isFav,
        doctorInfo: widget.doctorInfo,
      );
}
