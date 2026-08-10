import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/home/presentation/constants/bottom_nav_constants.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';

class BottomNavSearchButton extends StatefulWidget {
  final bool isFabHidden;

  const BottomNavSearchButton({super.key, required this.isFabHidden});

  @override
  State<BottomNavSearchButton> createState() => _BottomNavSearchButtonState();
}

class _BottomNavSearchButtonState extends State<BottomNavSearchButton> {
  final ValueNotifier<bool> _isKeyboardVisibleNotifier = ValueNotifier<bool>(
    false,
  );
  late final KeyboardDetectionController _keyboardDetectionController;

  @override
  void initState() {
    super.initState();

    _keyboardDetectionController = KeyboardDetectionController(
      onChanged: (state) {
        final isVisible =
            _keyboardDetectionController.stateAsBool(true) ?? false;
        _isKeyboardVisibleNotifier.value = isVisible;
      },
    );
  }

  @override
  void dispose() {
    _isKeyboardVisibleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDetection(
      controller: _keyboardDetectionController,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isKeyboardVisibleNotifier,
        builder: (context, isKeyboardVisible, child) {
          final shouldHide = widget.isFabHidden || isKeyboardVisible;

          return AnimatedSlide(
            // Offset(0, 0) is the natural position; Offset(0, 2) pushes the FAB down off-screen
            offset: shouldHide ? const Offset(0, 2) : const Offset(0, 0),
            duration: AppDurations.seconds_2,
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              // Fades the FAB out while sliding down, and fades in when sliding up
              opacity: shouldHide ? 0.0 : 1.0,
              duration: AppDurations.seconds_1,
              child: child,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(12.0.r),
          child: FloatingActionButton(
            backgroundColor: AppColors.customWhite,
            foregroundColor: AppColors.softBlue,
            elevation: 2,
            splashColor: AppColors.softBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
              side: const BorderSide(color: AppColors.softBlue, width: 1.7),
            ),
            child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 20.r),
            onPressed: () => context.read<BottomNavCubit>().changeTabIndex(
              BottomNavConstants.searchTabIndex,
            ),
          ),
        ),
      ),
    );
  }
}
