import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

class EmailAlreadyInUseSnackBarContent extends StatelessWidget {
  final void Function() onSignInPressed;
  final void Function() onDismissPressed;

  const EmailAlreadyInUseSnackBarContent({
    super.key,
    required this.onSignInPressed,
    required this.onDismissPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.red, AppColors.primaryColor],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [BoxShadow(color: Colors.white, blurRadius: 0.5)],
                ),

                child: const FaIcon(
                  FontAwesomeIcons.xmark,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  AppStrings.emailAlreadyInUseError,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              TextButton(
                onPressed: onDismissPressed,
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(1),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  minimumSize: const WidgetStatePropertyAll(Size(0, 0)),
                  backgroundColor: const WidgetStatePropertyAll(
                    Colors.transparent,
                  ),
                  foregroundColor: const WidgetStatePropertyAll(Colors.white60),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                child: Text(
                  AppStrings.dismiss,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: onSignInPressed,
                style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(1),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  minimumSize: const WidgetStatePropertyAll(Size(0, 0)),
                  backgroundColor: const WidgetStatePropertyAll(
                    AppColors.primaryButtonBlue,
                  ),
                  foregroundColor: const WidgetStatePropertyAll(
                    AppColors.white,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.white70),
                    ),
                  ),
                ),
                child: Text(
                  AppStrings.signIn.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
