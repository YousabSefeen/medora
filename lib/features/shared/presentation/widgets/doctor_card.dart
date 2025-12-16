import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/appointments/presentation/screens/create_appointment_screen.dart'
    show CreateAppointmentScreen;
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;
import 'package:medora/features/shared/presentation/widgets/doctor_basic_info.dart'
    show DoctorBasicInfo;
import 'package:medora/features/shared/value_objects/doctor_card_config.dart'
    show DoctorCardConfig;

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: Colors.black12, width: 0.5),
      ),
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      child: InkWell(
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
        borderRadius: BorderRadius.circular(12.r),
        overlayColor: const WidgetStatePropertyAll(AppColors.softBlue),
        onTap: () =>
            AppRouter.push(context, CreateAppointmentScreen(doctor: doctor)),
        child: DoctorBasicInfo(
          doctor: doctor,
          config: const DoctorCardConfig(
            imageSize: 80,
            imageRadius: 8,
            showFavoriteButton: true,
            nameFontSize: 16,
            specialtiesFontSize: 12,
            ratingIconSize: 16,
            ratingFontSize: 12,
          ),
        ),
      ),
    );
  }
}
