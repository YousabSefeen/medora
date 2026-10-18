import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/common_widgets/custom_shimmer.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/home/presentation/constants/home_constants.dart';
import 'package:medora/features/user/presentation/controllers/states/user_states.dart';

import '../../../../generated/assets.dart';
import '../../../user/presentation/controllers/cubit/user_cubit.dart';

class UserGreetingSection extends StatelessWidget {
  const UserGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      buildWhen: (UserStates previous, UserStates current) =>
          current is GetUserDataLoading ||
          current is GetUserDataSuccess ||
          current is GetUserDataFailure,
      builder: (context, state) {
        if (state is GetUserDataLoading) {
          return const _LoadingState();
        } else if (state is GetUserDataSuccess) {
          return _USerData(
            name: state.userEntity.name,
            imageUrl: state.userEntity.imageUrl,
          );
        } else {
          return const _USerData(
            name: AppStrings.user,
            imageUrl: AppStrings.defaultUserImageUrl,
          );
        }
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomShimmer(height: 40, width: 40),
        CustomShimmer(height: 30, width: 100),
      ],
    );
  }
}

class _USerData extends StatelessWidget {
  final String name;
  final String imageUrl;

  const _USerData({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HomeConstants.appBarWidth(context),
      height: HomeConstants.barContentHeight,
      child: Row(
        spacing: 10,
        children: [
          CircleAvatar(
            radius: 20.r,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, _) => Assets.images.loading.image(),
                errorWidget: (context, _, _) => Assets.images.error.image(),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'Good Morning!',
                style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                  color: AppColors.softBlue,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
