import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/common_widgets/custom_shimmer.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../user/presentation/controllers/cubit/user_cubit.dart';
import '../../../user/presentation/controllers/states/user_states.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

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
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.softBlue, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 25.r,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: state.userEntity.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, _) =>
                            Assets.images.loading.image(),
                        errorWidget: (context, _, _) =>
                            Assets.images.error.image(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userEntity.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.userEntity.email,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.softBlue.withValues(alpha: 0.1),
                  ),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.softBlue,
                    size: 20.r,
                  ),
                  onPressed: () {
                    // تعديل الملف الشخصي
                  },
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
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
