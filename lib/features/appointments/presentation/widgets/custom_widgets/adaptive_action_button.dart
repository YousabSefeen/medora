import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/themes/app_colors.dart';

class AdaptiveActionButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final bool isLoading;
  final void Function() onPressed;
  final double bottomHeight;

  const AdaptiveActionButton({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.onPressed,
    required this.isLoading,
    this.bottomHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: bottomHeight,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: _buildButtonStyle(isEnabled),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : _buildButtonText(),
      ),
    );
  }

  ButtonStyle _buildButtonStyle(bool isEnabled) => ButtonStyle(
    elevation: const WidgetStatePropertyAll(1),
    backgroundColor: WidgetStatePropertyAll(
      isEnabled ? AppColors.softBlue : AppColors.customWhite,
    ),
    foregroundColor: WidgetStatePropertyAll(
      isEnabled ? Colors.white : Colors.black,
    ),
    side: WidgetStatePropertyAll(
      isEnabled
          ? const BorderSide(color: Colors.transparent)
          : const BorderSide(color: AppColors.black12),
    ),
  );

  Widget _buildButtonText() => Text(
    title,
    style: GoogleFonts.roboto(fontSize: 19.sp, fontWeight: FontWeight.w700),
  );
}
