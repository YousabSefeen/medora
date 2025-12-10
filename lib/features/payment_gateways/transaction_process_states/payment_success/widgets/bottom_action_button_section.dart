import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';

class BottomActionButtonSection extends StatelessWidget {
  const BottomActionButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Total: ',
                    style: textTheme.largeBlackBold.copyWith(letterSpacing: 2),
                    children: [
                      TextSpan(
                        text:
                            '${context.read<AppointmentCubit>().pickedDoctorInfo.doctorModel.fees} EGP',
                        style: textTheme.numbersStyle.copyWith(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black45),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const _DoneButton(),
        ],
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 15.h),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(AppColors.softBlue),
          foregroundColor: const WidgetStatePropertyAll(AppColors.white),
          overlayColor: const WidgetStatePropertyAll(Colors.grey),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        onPressed: () => _navigateToDoctorList(context),
        child: Text(
          'Done',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: .05,
          ),
        ),
      ),
    );
  }

  void _navigateToDoctorList(BuildContext context) =>
      AppRouter.pushAndRemoveUntil(context, const BottomNavScreen());
}
