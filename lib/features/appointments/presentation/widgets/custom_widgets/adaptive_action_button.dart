import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/themes/app_colors.dart';

class AdaptiveActionButton extends StatelessWidget {
  final String title;
  final bool isEnabled;
  final bool isLoading;
  final void Function() onPressed;

  const AdaptiveActionButton({
    super.key,
    required this.title,
    required this.isEnabled,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: _getButtonStyle(isEnabled),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : _buildButtonText(),
      ),
    );
  }

  /// Returns the appropriate button style based on disabled state
  ButtonStyle _getButtonStyle(bool isEnabled) {
    return ButtonStyle(
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
  }

  /// Builds the text widget for the button with consistent styling
  Widget _buildButtonText() {
    return Text(
      title,
      style: GoogleFonts.roboto(fontSize: 19.sp, fontWeight: FontWeight.w700),
    );
  }
}
