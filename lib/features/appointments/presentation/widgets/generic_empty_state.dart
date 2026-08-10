import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/features/appointments/presentation/constants/empty_state_config.dart';


class GenericEmptyState extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String subtitle;
  final EmptyStateConfig config;

  const GenericEmptyState({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.subtitle,
    this.config = const EmptyStateConfig(),

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.all(config.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLottieAnimation(),

          _buildTitle(),
          SizedBox(height: 8.h),
          _buildSubtitle(),
        ],
      ),
    );
  }

  Widget _buildLottieAnimation() => Lottie.asset(
    lottiePath,
    width: config.lottieSize.w,
    height: config.lottieSize.h,
    fit: BoxFit.contain,
  );

  Widget _buildTitle() => Text(
    title,
    style: _getBaseTextStyle(),
    textAlign: TextAlign.center,
  );

  Widget _buildSubtitle() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      subtitle,
      style: TextStyle(
          color: Colors.grey.shade600, // Replace with AppColors.customBlueGrey
          fontSize:config.subtitleSize,
          fontWeight: FontWeight.w500,
          height: 1.9
      ),
      textAlign: TextAlign.center,
    ),
  );

  // Centralized text style for maintainability
  TextStyle _getBaseTextStyle() =>  GoogleFonts.poppins(
      textStyle: TextStyle(
        color: Colors.black, // Replace with AppColors.darkBlue
        height: 1.9,
        fontSize: config.titleSize,
        fontWeight: FontWeight.w600,
      )
  );
}