import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    show KeyboardVisibilityBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/home/presentation/constants/bottom_nav_constants.dart'
    show BottomNavConstants;
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart'
    show BottomNavCubit;

class BottomNavSearchButton extends StatelessWidget {
  final bool isFabHidden;

  const BottomNavSearchButton({super.key, required this.isFabHidden});

  @override
  Widget build(BuildContext context) {
    return isFabHidden
        ? const SizedBox()
        : KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) => isKeyboardVisible
                ? const SizedBox()
                : FloatingActionButton(
                    backgroundColor: AppColors.customWhite,
                    foregroundColor: AppColors.softBlue,
                    elevation: 2,
                    splashColor: AppColors.softBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                      side: const BorderSide(
                        color: AppColors.softBlue,
                        width: 1.7,
                      ),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20.sp,
                    ),
                    onPressed: () => context
                        .read<BottomNavCubit>()
                        .changeTabIndex(BottomNavConstants.searchTabIndex),
                  ),
          );
  }
}
