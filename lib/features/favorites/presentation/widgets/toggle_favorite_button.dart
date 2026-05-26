import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/animation_type.dart' show AnimationType;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart'
    show FavoritesCubit;
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart'
    show FavoritesStates;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;

class ToggleFavoriteButton extends StatelessWidget {
  final DoctorEntity doctorInfo;

  const ToggleFavoriteButton({super.key, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesStates>(
      listenWhen: (_, current) => current.toggleState == LazyRequestState.error,
      listener: (context, state) {
        if (state.toggleState == LazyRequestState.error) {
          AppAlerts.showSnackBar(context, state.toggleError);
          context.read<FavoritesCubit>().clearToggleState();
        }
      },

      child: BlocBuilder<FavoritesCubit, FavoritesStates>(
        buildWhen: (previous, current) =>
            previous.favoriteIds != current.favoriteIds,
        builder: (context, state) {
          final isFav = state.favoriteIds.contains(doctorInfo.doctorId);

          return _toggleFavoriteButton(isFav, context);
        },
      ),
    );
  }

  CustomAnimationTransition _toggleFavoriteButton(
    bool isFav,
    BuildContext context,
  ) {
    final icon = isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart;
    final iconColor = isFav ? AppColors.red : Colors.black54;
    return CustomAnimationTransition(
      animationType: AnimationType.fade,
      duration: AppDurations.milliseconds_600,
      child: IconButton(
        key: ValueKey(isFav),
        iconSize: 24.sp,
        icon: FaIcon(icon, color: iconColor),
        onPressed: () => context.read<FavoritesCubit>().toggleFavorite(
          isFavorite: isFav,
          doctorInfo: doctorInfo,
        ),
      ),
    );
  }
}
