import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/lottie_string_asset_ext.dart'
    show LottieStringAssetExtension;
import 'package:medora/core/extensions/media_query_extension.dart'
    show MediaQueryExtension;
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import 'package:medora/generated/assets.dart' show Assets;

class FavoritesEmptyList extends StatelessWidget {
  const FavoritesEmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return SliverFillRemaining(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: context.screenHeight * 0.1),
            _buildLottieAnimation(context),
            const SizedBox(height: 24),
            _buildTitle(textTheme),
            const SizedBox(height: 12),
            _buildDescription(textTheme),
            const SizedBox(height: 40),
            _buildBrowseButton(context),
          ],
        ),
      ),
    );
  }

  Text _buildTitle(TextTheme textTheme) =>
      Text(AppStrings.favoritesEmptyTitle, style: textTheme.headlineMediumEx);

  Text _buildDescription(TextTheme textTheme) => Text(
    AppStrings.favoritesEmptyDescription,
    style: textTheme.bodyMediumEx,
    textAlign: TextAlign.center,
  );

  Widget _buildLottieAnimation(BuildContext context) => Assets
      .lottie
      .noFavoriteDoctors
      .lottie(fit: BoxFit.cover, height: context.screenHeight * 0.3);

  Widget _buildBrowseButton(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.softBlue,
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
    ),
    onPressed: () => context.read<BottomNavCubit>().changeTabIndex(0),
    child: const Text(AppStrings.doctorsBrowse),
  );
}
