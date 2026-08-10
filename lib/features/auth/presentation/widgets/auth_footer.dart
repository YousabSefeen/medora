import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/auth/presentation/widgets/social_auth_button.dart';
import 'package:medora/generated/assets.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback onGoogleSignIn;
  final VoidCallback onFacebookSignIn;
  final VoidCallback? onAppleSignIn;
  final VoidCallback? onNavigateToSignUp;
  final VoidCallback? onNavigateToSignIn;
  final bool isSignInScreen;

  const AuthFooter({
    super.key,
    required this.onGoogleSignIn,
    required this.onFacebookSignIn,
    this.onAppleSignIn,
    this.onNavigateToSignUp,
    this.onNavigateToSignIn,
    required this.isSignInScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthDivider(
          title: isSignInScreen
              ? AppStrings.orSignInWith
              : AppStrings.orSignUpWith,
        ),
        _SocialAuthSection(
          onGoogle: onGoogleSignIn,
          onFacebook: onFacebookSignIn,
        ),
        AccountSwitchSection(
          isSignInScreen: isSignInScreen,
          onPressed: isSignInScreen ? onNavigateToSignUp : onNavigateToSignIn,
        ),
      ],
    );
  }
}

// 1. Divider Widget
class AuthDivider extends StatelessWidget {
  final String title;

  const AuthDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      child: Row(
        spacing: 10,
        children: [
          const Expanded(child: Divider()),

          Text(title, style: context.textTheme.authFieldTitle),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

// 2. Social Buttons Widget
class _SocialAuthSection extends StatelessWidget {
  final VoidCallback onGoogle;
  final VoidCallback onFacebook;

  const _SocialAuthSection({
    super.key,
    required this.onGoogle,
    required this.onFacebook,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        SocialAuthButton(
          svgGenImage: Assets.svg.googleLogo,
          onPressed: onGoogle,
        ),

        SocialAuthButton(
          svgGenImage: Assets.svg.facebookLogo,
          onPressed: onFacebook,
        ),
      ],
    );
  }
}

// 3. Account Switch Widget
class AccountSwitchSection extends StatelessWidget {
  final bool isSignInScreen;
  final VoidCallback? onPressed;

  const AccountSwitchSection({
    super.key,
    required this.isSignInScreen,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isSignInScreen
              ? AppStrings.dontHaveAccountText
              : AppStrings.alreadyHaveAccountText,
          style: context.textTheme.forgotButton.copyWith(color: Colors.white60),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            isSignInScreen ? AppStrings.signUp : AppStrings.signIn,
            style: context.textTheme.forgotButton,
          ),
        ),
      ],
    );
  }
}
