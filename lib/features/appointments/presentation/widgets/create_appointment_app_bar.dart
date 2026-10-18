import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/core/extensions/theme_extension.dart';

import '../../../../generated/assets.dart';
import '../../../shared/domain/entities/doctor_entity.dart';
import '../../../shared/presentation/widgets/rating_bar_badge.dart';

class CreateAppointmentAppBar extends StatelessWidget {
  final DoctorEntity doctor;
  final NavigationSource navigationSource;

  const CreateAppointmentAppBar({
    super.key,
    required this.doctor,

    required this.navigationSource,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      expandedHeight: context.screenHeight * 0.35,
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: CircleAvatar(
          radius: 15.r,
          backgroundColor: Colors.white.withValues(alpha: 0.85),
          child: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: AppColors.softBlue,
            size: 14.sp,
          ),
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: _FlexibleAppBarContent(
        doctor: doctor,
        navigationSource: navigationSource,
      ),
    );
  }
}

class _FlexibleAppBarContent extends StatelessWidget {
  final DoctorEntity doctor;
  final NavigationSource navigationSource;

  const _FlexibleAppBarContent({
    required this.doctor,
    required this.navigationSource,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isCollapsed =
            constraints.maxHeight <=
            kToolbarHeight + MediaQuery.of(context).padding.top;

        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(left: 56.w, bottom: 16.h),
          title: isCollapsed
              ? Text(
                  'Dr. ${doctor.name.toCapitalizeFirstLetter()}',
                  style: context.textTheme.extraLargeWhiteBold.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.darkBlue,
                  ),
                )
              : null,
          background: Stack(
            children: [
              // AppBar background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    // color: AppColors.customWhite,
                    // borderRadius: BorderRadius.circular(20.r),
                    //   border:Border.all(color: Colors.black12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      transform: GradientRotation(20.r),
                      colors: [
                        Colors.blue.shade100,
                        AppColors.white,
                        AppColors.white,
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 40.h,
                right: -18,
                bottom: 40.h,
                width: context.screenWidth * 0.52,
                child: navigationSource == NavigationSource.search
                    ? CachedNetworkImage(
                        alignment: Alignment.bottomCenter,
                        imageUrl: doctor.imageUrl,

                        fit: BoxFit.contain,

                        placeholder: (context, _) => const SizedBox.shrink(),
                        errorWidget: (context, _, _) => Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Assets.images.error.image(
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      )
                    : Hero(
                        tag: doctor.doctorId!,
                        child: CachedNetworkImage(
                          alignment: Alignment.bottomCenter,
                          imageUrl: doctor.imageUrl,

                          fit: BoxFit.contain,

                          placeholder: (context, _) => const SizedBox.shrink(),
                          errorWidget: (context, _, _) => Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Assets.images.error.image(
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
              ),

              Positioned(
                top: 100.h,
                left: 16.w,
                width: context.screenWidth * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Dr. ${doctor.name.toCapitalizeFirstLetter()}',

                      style: context.textTheme.doctorName.copyWith(
                        fontSize: 22.sp,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      doctor.specialties.first,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.dustyBlue,
                      ),
                    ),

                    SizedBox(height: 6.h),
                    Text(
                      '${doctor.doctorAvailability.availableFrom} - ${doctor.doctorAvailability.availableTo}',

                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.midnightBlue,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        RatingBarBadge(
                          initialRating: doctor.rating,
                          itemSize: 12.r,
                          onRatingUpdate: (double p1) {},
                        ),
                        Text(
                          doctor.rating.toString(),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,

                            color: AppColors.midnightBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // كارت الإحصائيات داخل الحدود الكاملة لمنع القص
              if (!isCollapsed)
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 0.h,
                  // رفعه قليلاً لتظهر جميع نصوصه كـ Experience, Patients, Fee's
                  child: DoctorStatsCard(
                    experience: '10y+',
                    patientsCount: doctor.patientsCount,
                    fees: doctor.fees,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class DoctorStatsCard extends StatelessWidget {
  final String experience;
  final int patientsCount;
  final int fees;

  const DoctorStatsCard({
    super.key,
    required this.experience,
    required this.patientsCount,
    required this.fees,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),

        //  filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        // تأثير الزجاج الضبابي فوق الصورة
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [1, 1],
              colors: [
                Colors.grey.withValues(alpha: 0.2),
                Colors.white.withValues(alpha: 0.2),
              ],
            ),

            // أبيض شبه شفاف
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.grey.shade500, width: 0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(title: experience, subtitle: 'Experience'),
              _buildDivider(),
              _buildStatItem(title: '${patientsCount}k', subtitle: 'Patients'),
              _buildDivider(),
              _buildStatItem(title: '\$$fees', subtitle: "Fee's"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({required String title, required String subtitle}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 22.h,
      width: 1.w,
      color: Colors.grey.withOpacity(0.25),
    );
  }
}
