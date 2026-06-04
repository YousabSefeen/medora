import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/animation_type.dart' show AnimationType;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class ToggleFavoriteButton extends StatelessWidget {
  final DoctorEntity doctorInfo;

  const ToggleFavoriteButton({super.key, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesState>(
      listenWhen: (prev, curr) => prev.toggleState != curr.toggleState,
      listener: _handleFavoriteToggleError,
      child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
        selector: (state) => state.isFavorite(doctorInfo.doctorId!),
        builder: (context, isFav) => _buildIconButton(context, isFav),
      ),
    );
  }

  /// Handles UI side effects when the toggle process fails.
  void _handleFavoriteToggleError(BuildContext context, FavoritesState state) {
    if (state.toggleState == RequestState.error) {
      AppAlerts.showSnackBar(context, AppStrings.toggleFavoriteErrorMsg);
    }
  }

  Widget _buildIconButton(BuildContext context, bool isFav) =>
      CustomAnimationTransition(
        animationType: AnimationType.fade,
        duration: AppDurations.milliseconds_600,
        child: IconButton(
          // Using Key helps activate the animation when toggle icons
          key: ValueKey(isFav),
          icon: FaIcon(
            isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: isFav ? AppColors.red : Colors.black54,
          ),
          onPressed: () => context.read<FavoritesCubit>().toggleFavorite(
            isCurrentlyFavorite: isFav,
            doctorInfo: doctorInfo,
          ),
        ),
      );
}
