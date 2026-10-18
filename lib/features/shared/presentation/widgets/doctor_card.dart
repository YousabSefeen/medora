import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';

import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/enum/navigation_source.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../generated/assets.dart';
import '../../../favorites/presentation/widgets/toggle_favorite_button.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(doctor.doctorId),
      width: 335.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      padding: const EdgeInsetsGeometry.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B4370).withValues(alpha: 0.06),
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DoctorCardHeader(),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          _DoctorCardFooter(doctor: doctor),
        ],
      ),
    );
  }
}

class _DoctorCardHeader extends StatelessWidget {
  const _DoctorCardHeader({super.key});

  static final double _imageSize = 80;

  @override
  Widget build(BuildContext context) {
    final doctor = context.findAncestorWidgetOfExactType<DoctorCard>()!.doctor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, AppColors.white, AppColors.white],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            //    padding: EdgeInsets.all(2),
            width: _imageSize + 5,
            height: _imageSize + 5,
            padding: const EdgeInsets.only(top: 3),

            /// alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.white, AppColors.softBlue],
                radius: 0.85,
              ),
              color: Colors.white,
            ),

            child: Hero(
              tag: doctor.doctorId!,
              child: ClipRRect(
                borderRadius: const BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(180),
                  bottomRight: Radius.circular(180),
                ),
                child: CachedNetworkImage(
                  imageUrl: doctor.imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, _) => ClipOval(
                    child: Assets.images.loading.image(
                      fit: BoxFit.cover,
                      width: 75.r,
                      height: 75.r,
                    ),
                  ),
                  errorWidget: (context, _, _) => ClipOval(
                    child: Assets.images.error.image(
                      fit: BoxFit.cover,
                      width: 75.r,
                      height: 75.r,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Name + Favorite Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        //   'Dr. ${doctor.name.toCapitalizeFirstLetter()}',
                        '${AppStrings.dR}${doctor.name.toCapitalizeFirstLetter()}',
                        style: context.textTheme.doctorName.copyWith(
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                      ),
                    ),

                    const SizedBox(width: 10),

                    ToggleFavoriteButton(doctorInfo: doctor),
                  ],
                ),

                // Specialty
                Text(
                  doctor.specialties.first,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.dustyBlue,
                    ),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),

                // Rating
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 11.sp,
                      color: const Color(0xFFFF4D4D),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      doctor.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        '|  ${doctor.ratingCount} ${AppStrings.reviews}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF8D99AE),
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: AppColors.steelGray,
                      size: 14.sp,
                    ),

                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        doctor.location,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF6C7A89),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCardFooter extends StatelessWidget {
  final DoctorEntity doctor;

  const _DoctorCardFooter({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: doctor.fees.toString(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0F2B48),
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: ' EGP',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2B48),
                  ),
                ),
                TextSpan(
                  text: '\nper visit',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF94A3B8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 32.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: const LinearGradient(
                colors: [AppColors.softBlue, Color(0xFF1E88E5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2196F3).withOpacity(0.35),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () => _navigatorToCreateAppointment(context, doctor),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    AppStrings.bookNow,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigatorToCreateAppointment(
    BuildContext context,
    DoctorEntity doctor,
  ) {
    final Map<String, dynamic> extra = {
      'doctor': doctor,
      'navigationSource': NavigationSource.direct,
    };
    context.push(AppRouterNames.createAppointment, extra: extra);
  }
}
