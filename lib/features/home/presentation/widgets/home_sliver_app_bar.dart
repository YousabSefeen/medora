import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/home/presentation/constants/home_constants.dart';
import 'package:medora/features/home/presentation/widgets/home_app_bar.dart';

import '../../../../core/extensions/media_query_extension.dart';
import '../../../../generated/assets.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  String _getFormattedCloudinaryUrl(String originalUrl) {
    if (!originalUrl.contains('/upload/')) {
      return originalUrl;
    }

    // e_background_removal : إزالة الخلفية
    // c_limit,w_500,h_600   : التحجم الذكي الذي يحافظ على أبعاد الطبيب الكاملة بدون اقتصاص جزء من رأسه أو جسمه
    const transformations = 'c_limit,w_600,h_800,e_background_removal';

    String formattedUrl = originalUrl.replaceAll(
      '/upload/',
      '/upload/$transformations/',
    );

    if (formattedUrl.contains('.jpg')) {
      formattedUrl = formattedUrl.replaceAll('.jpg', '.png');
    } else if (formattedUrl.contains('.jpeg')) {
      formattedUrl = formattedUrl.replaceAll('.jpeg', '.png');
    }

    return formattedUrl;
  }

  @override
  Widget build(BuildContext context) {
    final image = _getFormattedCloudinaryUrl(
      'https://res.cloudinary.com/dfls3gdea/image/upload/v1788041964/dr_default_ssgcpx.png',
    );

    return SliverAppBar(
      pinned: true,

      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: const HomeAppBar(),
      ),
      elevation: 0,
      toolbarHeight: HomeConstants.appBarHeight,
      expandedHeight: context.screenHeight * 0.2 + kToolbarHeight,

      backgroundColor: AppColors.customWhite,

      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(
            top: 15.h + kToolbarHeight,
            right: 10,
            left: 10,
          ),
          child: Container(
            padding: EdgeInsetsGeometry.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.softBlue,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0.h,
                  left: 5.w,
                  bottom: 0.h,
                  width: context.screenWidth * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ask AI Doctor',
                        style: context.textTheme.authButton.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          'Find the right doctor & get instant symptom guidance.',
                          style: context.textTheme.hintFieldStyle.copyWith(
                            color: Colors.white70,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              context.push(AppRouterNames.geminiChat),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.customWhite,
                            shadowColor: Colors.transparent,

                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 5.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            AppStrings.askNow,
                            style: context.textTheme.trailingText.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 0.h,
                  bottom: 0.h,
                  right: 0.w,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,

                    placeholder: (context, _) => const SizedBox.shrink(),
                    errorWidget: (context, _, _) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20.r),
                        child: Assets.images.error.image(fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
