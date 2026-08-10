import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/enum/user_type.dart';

class SignUpRoleSelector extends StatelessWidget {
  final TextEditingController roleController;
    SignUpRoleSelector({super.key, required this.roleController});
    final ValueNotifier<UserType> _userType = ValueNotifier<UserType>(UserType.client);
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
          ValueListenableBuilder<UserType>(
              valueListenable: _userType,
              builder: (context, userType, child) {
                return Row(
                  children: [
                    Expanded(
                      child: _RoleOption(
                        title: 'Client',
                        isActive: userType == UserType.client,
                        onTap: () {
                          _userType.value = UserType.client;
                         roleController.text = 'client';
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: _RoleOption(
                        title: 'Doctor',
                        isActive: userType == UserType.doctor,
                        onTap: () {
                          _userType.value = UserType.doctor;
                          roleController.text = 'doctor';
                        },
                      ),
                    ),
                  ],
                );
              }
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
