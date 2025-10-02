import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';

class SpecialtyCard extends StatelessWidget {
  final String specialtyName;
  final String imagePath;
  final void Function() onTap;

  const SpecialtyCard({
    super.key,
    required this.specialtyName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final BorderRadius borderRadius = BorderRadius.circular(8.r);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: borderRadius,
        overlayColor: const WidgetStatePropertyAll(AppColors.softBlue),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Image.asset(
                imagePath,
                height: screenHeight * 0.08,
                fit: BoxFit.cover,
              ),
              Text(
                specialtyName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.smallGreyMedium.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
