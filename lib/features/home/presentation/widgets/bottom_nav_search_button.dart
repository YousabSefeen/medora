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
            offset: shouldHide ? const Offset(0, 2) : const Offset(0, 0),
            duration: AppDurations.seconds_2,
            curve: Curves.easeOutBack,
            child: AnimatedOpacity(
              opacity: shouldHide ? 0.0 : 1.0,
              duration: AppDurations.seconds_1,
              child: child,
            ),
          );
        },
        // Use Transform.translate to lower the button vertically to the level of the bar's perimeter
        child: Transform.translate(
          offset: const Offset(0, 5),
          // Move the circle down by **5** pixels within the cavity
          child: Container(
            width: 50.r,
            height: 50.r,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.customWhite,
              border: Border.all(
                color: AppColors.softBlue.withValues(alpha: 0.3),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softBlue.withValues(alpha: 0.12),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,

              child: InkWell(
                onTap: () => context.read<BottomNavCubit>().changeTabIndex(
                  BottomNavConstants.searchTabIndex,
                ),
                splashColor: AppColors.softBlue.withValues(alpha: 0.15),
                highlightColor: Colors.transparent,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 18.r,
                    color: AppColors.softBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
