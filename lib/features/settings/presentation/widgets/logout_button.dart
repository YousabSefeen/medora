import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../../../auth/presentation/controller/cubit/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.brightRed.withValues(alpha: 0.9),
          foregroundColor: AppColors.white,
          side: const BorderSide(color: AppColors.brightRed, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          context.read<AuthCubit>().signOut();
          context.go(AppRouterNames.signIn);
        },
        icon: const Icon(Icons.logout_rounded),
        label: Text(
          AppStrings.logout,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
