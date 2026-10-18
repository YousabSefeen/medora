import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/animations/custom_animation_transition.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/animation_type.dart';
import 'package:medora/core/enum/request_state.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'package:medora/features/favorites/presentation/controller/states/favorites_states.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

class ToggleFavoriteButton extends StatelessWidget {
  final DoctorEntity doctorInfo;
  final double? iconSize;
  final double? paddingIcon;

  const ToggleFavoriteButton({
    super.key,
    required this.doctorInfo,
    this.iconSize = 15,
    this.paddingIcon = 5,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesCubit, FavoritesState>(
      listenWhen: (prev, curr) => prev.toggleState != curr.toggleState,
      listener: (BuildContext context, FavoritesState state) {
        if (state.toggleState == RequestState.error) {
          OverlayNotificationService.show(
            context: context,
            message: AppStrings.toggleFavoriteErrorMsg,
            type: SnackBarType.error,
          );
        }
      },
      child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
        selector: (state) => state.isFavorite(doctorInfo.doctorId!),
        builder: (context, isFav) => CustomAnimationTransition(
          animationType: AnimationType.fade,
          duration: AppDurations.milliseconds_600,
          child: GestureDetector(
            key: ValueKey(isFav),

            onTap: () {
              AppLogger.error('Tap*************************');
              context.read<FavoritesCubit>().toggleFavorite(
              isCurrentlyFavorite: isFav,
              doctorInfo: doctorInfo,
            );
            },
            child: Container(
              padding: EdgeInsets.all(paddingIcon!),
              decoration:   BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.customWhite,
                boxShadow: [
                  BoxShadow(
                    color:AppColors.softBlue.withValues(alpha: 0.5),
                    blurRadius: 1,spreadRadius: 1
                  )
                ]
              ),
              child: FaIcon(
                isFav ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                size: iconSize!.sp,
                color: AppColors.softBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
