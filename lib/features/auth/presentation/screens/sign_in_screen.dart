import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/animations/animated_gradient_background.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/auth_validator.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/login_controllers.dart'
    show LoginControllers;
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_card.dart';
import 'package:medora/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:medora/features/auth/presentation/widgets/obscure_text_visibility_button.dart';
import 'package:medora/features/auth/presentation/widgets/sign_in_header.dart';

import '../../../../core/constants/themes/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final LoginControllers loginControllers;

  String? registeredUserEmail;
  final ValueNotifier<AutovalidateMode> _autoValidateMode =
      ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier<bool>(
    true,
  );

  void _initializeTextControllers() => loginControllers = LoginControllers();

  void _setEmailFromRegisterRoute() => Future.microtask(() {
    if (!mounted) return;
    registeredUserEmail = ModalRoute.of(context)?.settings.arguments as String?;
    loginControllers.emailController.text = registeredUserEmail ?? '';
  });

  @override
  void initState() {
    super.initState();

    _initializeTextControllers();
    _setEmailFromRegisterRoute();
  }

  @override
  void dispose() {
    loginControllers.dispose();
    _obscurePasswordNotifier.dispose();
    super.dispose();
  }

  void _submitForm() {
    FocusManager.instance.primaryFocus?.unfocus();

    _autoValidateMode.value = AutovalidateMode.always;
    if (loginControllers.formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
        SignInParams(
          email: loginControllers.emailController.text,
          password: loginControllers.passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthFailure || current is SignInSuccess,
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
                    key: loginControllers.formKey,
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
                                  isSignUp: false,
                                  title: AppStrings.email,
                                  controller: loginControllers.emailController,
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
                                        isSignUp: false,
                                        title: AppStrings.password,
                                        controller:
                                            loginControllers.passwordController,
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
                                    onPressed: () {},
                                    child: Text(
                                      AppStrings.forgotPassword,
                                      style: context.textTheme.forgotButton,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Login Button
                                AuthActionButton(
                                  onPressed: _submitForm,
                                  child:
                                      BlocSelector<AuthCubit, AuthState, bool>(
                                        selector: (state) =>
                                            state is AuthLoading,
                                        builder: (context, isLoading) {
                                          return isLoading
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  AppStrings.signIn,
                                                  style: context
                                                      .textTheme
                                                      .authButton,
                                                );
                                        },
                                      ),
                                ),

                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.dontHaveAccountText,
                                      style: context.textTheme.forgotButton
                                          .copyWith(color: Colors.white60),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                //   const NewRegisterScreen(),
                                                const SignUpScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        AppStrings.signUp,
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
          ),
        ),
      ),
    );
  }

  void _handleSignInListenerStates(BuildContext context, AuthState state) {
    if (state is SignInSuccess) {
      AppRouter.pushNamedAndRemoveUntil(
        context,
        AppRouterNames.bottomNavScreen,
      );
    } else if (state is AuthFailure) {
      AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
    }
  }
}
