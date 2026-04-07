import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_borders/app_borders.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/app_view_context.dart' show AppViewContext;
import 'package:medora/core/enum/medical_specialty_view_styles.dart'
    show MedicalSpecialtyViewStyles;
import 'package:medora/features/doctors_specialties/data/models/medical_specialty.dart'
    show MedicalSpecialty;
import 'package:medora/features/doctors_specialties/presentation/screens/specialty_doctors_screen.dart'
    show SpecialtyDoctorsScreen;

class SpecialtyCardItem extends StatelessWidget {
  final MedicalSpecialty specialty;
  final AppViewContext viewContext;

  const SpecialtyCardItem({
    super.key,
    required this.specialty,
    this.viewContext = AppViewContext.home,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: AppBorders.defaultBorderRadius,
        overlayColor: const WidgetStatePropertyAll(AppColors.softBlue),
        onTap: () => _navigateToSpecialtyDoctors(context),
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 105.w,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppBorders.defaultBorderRadius,
            border: AppBorders.faintBorder,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              _buildSpecialtyImage(context, viewContext),
              _buildSpecialtyName(context, viewContext),
            ],
          ),
        ),
      ),
    );
  }

  Image _buildSpecialtyImage(
    BuildContext context,
    AppViewContext viewContext,
  ) => Image.asset(
    specialty.image,
    height: viewContext.specialtyImageHeight(context),
    fit: BoxFit.cover,
  );

  Widget _buildSpecialtyName(BuildContext context, AppViewContext viewContext) {
    final textWidget = Text(
      specialty.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.smallGreyMedium.copyWith(
        fontSize: viewContext.specialtyFontSize,
        fontWeight: viewContext.specialtyFontWeight,
        color: Colors.black,
      ),
    );

    return viewContext.isSpecialtyView
        ? FittedBox(child: textWidget)
        : textWidget;
  }

  void _navigateToSpecialtyDoctors(BuildContext context) => AppRouter.push(
    context,
    SpecialtyDoctorsScreen(specialtyName: specialty.name),
  );
}
