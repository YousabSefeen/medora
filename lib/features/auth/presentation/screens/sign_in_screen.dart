import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/animations/animated_gradient_background.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/auth_provider_type.dart';
import 'package:medora/core/extensions/context_extension.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/auth_validator.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/login_controllers.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_card.dart';
import 'package:medora/features/auth/presentation/widgets/auth_footer.dart';
import 'package:medora/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:medora/features/auth/presentation/widgets/obscure_text_visibility_button.dart';
import 'package:medora/features/auth/presentation/widgets/sign_in_header.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';

import '../../../../core/constants/themes/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late final LoginControllers _signInControllers;

  String? registeredUserEmail;
  final ValueNotifier<AutovalidateMode> _autoValidateMode =
      ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier<bool>(
    true,
  );

  @override
  void initState() {
    super.initState();

    _signInControllers = LoginControllers();
  }

  @override
  void dispose() {
    _signInControllers.dispose();
    _obscurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: _listenWhen,

        listener: _handleSignInListenerStates,

        child: AnimatedGradientBackground(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _signInControllers.formKey,
                    autovalidateMode: _autoValidateMode.value,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const LoginHeader(),
                          SizedBox(height: context.screenHeight * 0.05),
                          AuthCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email Field
                                AuthFormField(
                                  title: AppStrings.email,
                                  controller:
                                      _signInControllers.emailController,
                                  hintText: AppStrings.emailHint,
                                  prefixIcon: Icons.mail_outline,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: AuthValidator.validateEmail,
                                ),
                                // Password Field
                                ValueListenableBuilder<bool>(
                                  valueListenable: _obscurePasswordNotifier,
                                  builder: (context, obscureText, child) =>
                                      AuthFormField(
                                        title: AppStrings.password,
                                        controller: _signInControllers
                                            .passwordController,
                                        hintText: AppStrings.passwordHint,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: obscureText,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator:
                                            AuthValidator.validatePassword,

                                        suffixIcon: ObscureTextVisibilityButton(
                                          isObscured: obscureText,
                                          onTap: () =>
                                              _obscurePasswordNotifier.value =
                                                  !_obscurePasswordNotifier
                                                      .value,
                                        ),
                                      ),
                                ),
                                // Forgot Password Button
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () =>
                                        _navigatorToPasswordRecovery(context),
                                    child: Text(
                                      '${AppStrings.forgotPassword}?',
                                      style: context.textTheme.forgotButton,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Login Button
                                AuthActionButton(
                                  onPressed: () => _submitForm(context),

                                  child:
                                      BlocSelector<AuthCubit, AuthState, bool>(
                                        selector: (AuthState state) {
                                          return state is AuthLoading &&
                                              state.providerType ==
                                                  AuthProviderType.email;
                                        },
                                        builder: (context, isLoading) =>
                                            isLoading
                                            ? const CustomCircularProgress()
                                            : Text(
                                                AppStrings.signIn,
                                                style: context
                                                    .textTheme
                                                    .authButton,
                                              ),
                                      ),
                                ),

                                AuthFooter(
                                  isSignInScreen: true,

                                  onGoogleSignIn: () => _signIn(
                                    context: context,
                                    params: const SignInParams(
                                      providerType: AuthProviderType.google,
                                    ),
                                  ),
                                  onFacebookSignIn: () => _signIn(
                                    context: context,
                                    params: const SignInParams(
                                      providerType: AuthProviderType.facebook,
                                    ),
                                  ),

                                  onNavigateToSignUp: () =>
                                      _navigateToSignUp(context),
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
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    _autoValidateMode.value = AutovalidateMode.always;
    if (_signInControllers.formKey.currentState!.validate()) {
      final params = SignInParams(
        providerType: AuthProviderType.email,
        email: _signInControllers.emailController.text.trim(),
        password: _signInControllers.passwordController.text.trim(),
      );
      _signIn(context: context, params: params);
    }
  }

  void _signIn({required BuildContext context, required SignInParams params}) =>
      context.read<AuthCubit>().signIn(params: params);

  void _navigateToSignUp(BuildContext context) =>
      context.push(AppRouterNames.signUp).then((signUpResult) {
        if (!mounted) return;

        if (signUpResult is String && signUpResult.isNotEmpty) {
          _signInControllers.emailController.text = signUpResult;
        }
      });

  bool _listenWhen(AuthState _, AuthState current) =>
      current is AuthLoading ||
      current is AuthSuccess ||
      current is AuthFailure;

  void _navigatorToPasswordRecovery(BuildContext context) async {
    await context.ensureKeyboardIsClosed();

    if (context.mounted) {
      context.push(
        AppRouterNames.forgetPassword,
        extra: {
          'email': _signInControllers.emailController.text.trim(),
          'currentPage': 0,
        },
      );
    }
  }

  void _handleSignInListenerStates(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      if (state.providerType == AuthProviderType.google ||
          state.providerType == AuthProviderType.facebook) {
        context.pop();
      }
      AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
    } else if (state is AuthLoading) {
      if (state.providerType == AuthProviderType.google ||
          state.providerType == AuthProviderType.facebook) {
        AppAlerts.showCircularProgressIndicatorLoadingDialog(context);
      }
    } else if (state is AuthSuccess) {
      context.go(AppRouterNames.bottomNav);
    }
  }
}
