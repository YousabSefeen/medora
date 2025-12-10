import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/themes/app_colors.dart';
import '../../../../../core/enum/user_type.dart';
import '../../controller/cubit/register_cubit.dart';
import '../../controller/states/register_state.dart';

class RegisterRoleSelector extends StatelessWidget {
  const RegisterRoleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 13, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registering as',
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              color: AppColors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          BlocSelector<RegisterCubit, RegisterState, UserType>(
            selector: (state) => state.userType,
            builder: (context, userType) => Row(
              children: [
                Expanded(
                  child: _RoleOption(
                    title: 'Client',
                    isActive: userType == UserType.client,
                    onTap: () => context.read<RegisterCubit>().toggleUserType(
                      UserType.client,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: _RoleOption(
                    title: 'Doctor',
                    isActive: userType == UserType.doctor,
                    onTap: () => context.read<RegisterCubit>().toggleUserType(
                      UserType.doctor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _RoleOption({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color: isActive ? Colors.green : Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isActive
                ? BorderSide.none
                : const BorderSide(color: Colors.white70),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.caladea(
            fontSize: 15.sp,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
