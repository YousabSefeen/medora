import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/animations/animated_gradient_background.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/auth_provider_type.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/auth_validator.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/register_controllers.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_card.dart';
import 'package:medora/features/auth/presentation/widgets/auth_footer.dart';
import 'package:medora/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:medora/features/auth/presentation/widgets/obscure_text_visibility_button.dart';
import 'package:medora/features/auth/presentation/widgets/sign_up_header.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';

import '../../../user/domain/value_objects/add_user_params.dart';
import '../../../user/presentation/controllers/cubit/user_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final RegisterControllers _signUpControllers;

  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier<bool>(
    true,
  );
  final ValueNotifier<bool> _obscureConfirmPasswordNotifier =
      ValueNotifier<bool>(true);

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  AuthProviderType _authProviderType = AuthProviderType.email;
  @override
  void initState() {
    // _authProviderType=AuthProviderType.email;
    _signUpControllers = RegisterControllers();

    super.initState();
  }

  @override
  void dispose() {
    _signUpControllers.dispose();
    super.dispose();
  }

  final double titleFontSize = 11.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: _listenWhen,
        listener: _handleSignUpListenerStates,
        child: AnimatedGradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 30.h),
              child: Form(
                key: _signUpControllers.formKey,
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
                            titleFontSize: titleFontSize,
                            controller: _signUpControllers.userNameController,
                            hintText: AppStrings.userNameHint,
                            prefixIcon: Icons.person_outline,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            validator: AuthValidator.validateUserName,
                          ),
                          AuthFormField(
                            title: AppStrings.phoneNumber,
                            titleFontSize: titleFontSize,
                            controller: _signUpControllers.phoneController,
                            hintText: AppStrings.phoneNumberHint,
                            prefixIcon: Icons.phone_outlined,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            validator: AuthValidator.validatePhoneNumber,
                          ),
                          AuthFormField(
                            title: AppStrings.email,
                            titleFontSize: titleFontSize,
                            controller: _signUpControllers.emailController,
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
                                  titleFontSize: titleFontSize,
                                  controller:
                                      _signUpControllers.passwordController,
                                  hintText: AppStrings.passwordHint,
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: obscureText,
                                  keyboardType: TextInputType.text,
                                  validator: AuthValidator.validatePassword,

                                  suffixIcon: ObscureTextVisibilityButton(
                                    isObscured: obscureText,
                                    onTap: _togglePasswordVisibility,
                                  ),
                                ),
                          ),

                          ValueListenableBuilder<bool>(
                            valueListenable: _obscureConfirmPasswordNotifier,
                            builder: (context, obscureText, child) =>
                                AuthFormField(
                                  title: AppStrings.confirmPassword,
                                  titleFontSize: titleFontSize,
                                  controller: _signUpControllers
                                      .confirmPasswordController,
                                  hintText: AppStrings.passwordHint,
                                  prefixIcon: Icons.lock_outline,
                                  obscureText: obscureText,
                                  keyboardType: TextInputType.text,
                                  validator: _validateConfirmPassword,
                                  suffixIcon: ObscureTextVisibilityButton(
                                    isObscured: obscureText,
                                    onTap: _toggleConfirmPasswordVisibility,

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
                                    ? const CustomCircularProgress()
                                    : Text(
                                        AppStrings.signUp,
                                        style: context.textTheme.authButton,
                                      );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          AuthFooter(
                            isSignInScreen: false,
                            onGoogleSignIn: () {
                              _authProviderType = AuthProviderType.google;
                              _signUp(
                                params: SignUpParams(
                                  providerType: _authProviderType,
                              ),
                              );
                            },
                            onFacebookSignIn: () {
                              _authProviderType = AuthProviderType.facebook;
                              _signUp(
                                params: SignUpParams(
                                  providerType: _authProviderType,
                              ),
                              );
                            },

                            onNavigateToSignIn: () => context.pop(),
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

  String? _validateConfirmPassword(String? value) =>
      AuthValidator.validateConfirmPassword(
        value,
        _signUpControllers.passwordController.text,
      );

  void _togglePasswordVisibility() =>
      _obscurePasswordNotifier.value = !_obscurePasswordNotifier.value;

  void _toggleConfirmPasswordVisibility() =>
      _obscureConfirmPasswordNotifier.value =
          !_obscureConfirmPasswordNotifier.value;

  void _submitForm() {
    _authProviderType = AuthProviderType.email;
    FocusManager.instance.primaryFocus?.unfocus();
    if (_autoValidateMode == AutovalidateMode.disabled) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
    }

    if (_signUpControllers.formKey.currentState!.validate()) {
      final params = SignUpParams(

        email: _signUpControllers.emailController.text.trim(),
        password: _signUpControllers.passwordController.text.trim(),
        providerType: AuthProviderType.email,
      );
      _signUp(params: params);
    }
  }

  void _signUp({required SignUpParams params}) {
    context.read<AuthCubit>().signUp(params: params);
  }

  bool _listenWhen(AuthState previous, AuthState current) =>
      current is AuthLoading ||
      current is AuthSuccess ||
      current is AuthFailure;

  void _handleSignUpListenerStates(BuildContext context,
      AuthState state) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (state is AuthSuccess) {
      if (_authProviderType == AuthProviderType.email) {
        await context.read<UserCubit>().addUser(params: AddUserParams(

          authProviderType: _authProviderType,
          name: _signUpControllers.userNameController.text.trim(),
          imageUrl: AppStrings.defaultUserImageUrl,
          phone: _signUpControllers.phoneController.text.trim(),
          email: _signUpControllers.emailController.text.trim(),
        ));
      } else {
        await context.read<UserCubit>().addUser(params: AddUserParams(

          authProviderType: _authProviderType,

        ));
      }

      if (!context.mounted) return;
      context.go(AppRouterNames.bottomNav);
    } else if (state is AuthFailure) {
      if (state.errorMessage == AppStrings.emailAlreadyInUseError) {
        _showEmailInUseDialog(context);
      } else {
        AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
      }
    }
  }

  void _showEmailInUseDialog(BuildContext context) {
    AppAlerts.showEmailAlreadyInUseSnackBar(
      context: context,
      onSignInPressed: () {
        _hideCurrentSnackBar(context);
        _navigateBackWithEmail(context);
      },
      onDismissPressed: () => _hideCurrentSnackBar(context),
    );
  }

  void _navigateBackWithEmail(BuildContext context) {
    final currentEmail = _signUpControllers.emailController.text;
    context.pop(currentEmail);
  }

  void _hideCurrentSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
