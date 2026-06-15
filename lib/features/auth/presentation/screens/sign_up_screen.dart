import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/animations/animated_gradient_background.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/auth_validator.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/register_controllers.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_card.dart';
import 'package:medora/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:medora/features/auth/presentation/widgets/obscure_text_visibility_button.dart';
import 'package:medora/features/auth/presentation/widgets/sign_up_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final RegisterControllers _controllers;

  void _initializeTextControllers() => _controllers = RegisterControllers();
  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier<bool>(
    true,
  );
  final ValueNotifier<bool> _obscureConfirmPasswordNotifier =
      ValueNotifier<bool>(true);
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    _initializeTextControllers();

    super.initState();
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    if (_controllers.formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        SignUpParams(
          name: _controllers.userNameController.text.trim(),
          phone: _controllers.phoneController.text.trim(),
          email: _controllers.emailController.text.trim(),
          password: _controllers.passwordController.text.trim(),
          role: _controllers.roleController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthFailure || current is SignInSuccess,
        listener: _handleSignUpListenerStates,
        child: AnimatedGradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 30.h),
              child: Form(
                key: _controllers.formKey,
                autovalidateMode: _autoValidateMode,
                child: Column(
                  spacing: 10,
                  children: [
                    const SignUpHeader(),
                    AuthCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthFormField(
                            title: AppStrings.userName,
                            controller: _controllers.userNameController,
                            hintText: AppStrings.userNameHint,
                            prefixIcon: Icons.person_outline,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            validator: AuthValidator.validateUserName,
                          ),
                          AuthFormField(
                            title: AppStrings.phoneNumber,
                            controller: _controllers.phoneController,
                            hintText: AppStrings.phoneNumberHint,
                            prefixIcon: Icons.phone_outlined,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            validator: AuthValidator.validatePhoneNumber,
                          ),
                          AuthFormField(
                            title: AppStrings.email,
                            controller: _controllers.emailController,
                            hintText: AppStrings.emailHint,
                            prefixIcon: Icons.mail_outline,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            validator: AuthValidator.validateEmail,
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: _obscurePasswordNotifier,
                            builder: (context, obscureText, child) =>
                                AuthFormField(
                                  title: AppStrings.password,
                                  controller: _controllers.passwordController,
                                  hintText: AppStrings.passwordHint,
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: obscureText,
                                  keyboardType: TextInputType.text,
                                  validator: AuthValidator.validatePassword,

                                  suffixIcon: ObscureTextVisibilityButton(
                                    isObscured: obscureText,
                                    onTap: () =>
                                        _obscurePasswordNotifier.value =
                                            !_obscurePasswordNotifier.value,
                                  ),
                                ),
                          ),

                          ValueListenableBuilder<bool>(
                            valueListenable: _obscureConfirmPasswordNotifier,
                            builder: (context, obscureText, child) =>
                                AuthFormField(
                                  title: AppStrings.confirmPassword,
                                  controller:
                                      _controllers.confirmPasswordController,
                                  hintText: AppStrings.passwordHint,
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: obscureText,
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      AuthValidator.validateConfirmPassword(
                                        value,
                                        _controllers.passwordController.text,
                                      ),
                                  suffixIcon: ObscureTextVisibilityButton(
                                    isObscured: obscureText,
                                    onTap: () =>
                                        _obscureConfirmPasswordNotifier.value =
                                            !_obscureConfirmPasswordNotifier
                                                .value,
                                  ),
                                ),
                          ),

                          const SizedBox(height: 12),
                          AuthActionButton(
                            onPressed: _submitForm,
                            child: BlocSelector<AuthCubit, AuthState, bool>(
                              selector: (state) => state is AuthLoading,
                              builder: (context, isLoading) {
                                return isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        AppStrings.signUp,
                                        style: context.textTheme.authButton,
                                      );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.alreadyHaveAccountText,
                                style: context.textTheme.forgotButton.copyWith(
                                  color: Colors.white60,
                                ),
                              ),
                              TextButton(
                                onPressed: () => AppRouter.pop(context),
                                child: Text(
                                  AppStrings.signIn,
                                  style: context.textTheme.forgotButton,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignUpListenerStates(BuildContext context, AuthState state) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (state is SignUpSuccess) {
      AppRouter.pushNamedAndRemoveUntil(
        context,
        AppRouterNames.bottomNavScreen,
      );
    } else if (state is AuthFailure) {
      if (state.errorMessage == AppStrings.emailAlreadyInUseError) {
        AppAlerts.showEmailAlreadyInUseSnackBar(
          context: context,
          onSignInPressed: () {
            _hideCurrentSnackBar(context);
            AppRouter.pushNamedAndRemoveUntil(
              context,
              AppRouterNames.signIn,
              arguments: _controllers.emailController.text.trim(),
            );
          },
          onDismissPressed: () => _hideCurrentSnackBar(context),
        );
      } else {
        AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
      }
    }
  }

  void _hideCurrentSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
