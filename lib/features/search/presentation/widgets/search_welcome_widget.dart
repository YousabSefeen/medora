import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/generated/assets.dart' show Assets;

class SearchWelcomeWidget extends StatelessWidget {
  const SearchWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _WelcomeImage(),
              SizedBox(height: 30),
              _WelcomeMessage(),
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeImage extends StatelessWidget {
  const _WelcomeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Image.asset(
          Assets.imagesStethoscope,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.searchEmptyMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );
  }
}
