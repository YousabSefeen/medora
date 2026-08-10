import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/auth_validator.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:medora/features/auth/presentation/widgets/auth_step_content_template.dart';
import 'package:medora/features/auth/presentation/widgets/obscure_text_visibility_button.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';
import 'package:medora/generated/assets.dart';

class ResetPasswordStep extends StatefulWidget {
  const ResetPasswordStep({super.key});

  @override
  State<ResetPasswordStep> createState() => _ResetPasswordStepState();
}

class _ResetPasswordStepState extends State<ResetPasswordStep> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final ValueNotifier<bool> _obscurePasswordNotifier;
  late final ValueNotifier<bool> _obscureConfirmPasswordNotifier;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _obscurePasswordNotifier = ValueNotifier<bool>(true);
    _obscureConfirmPasswordNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePasswordNotifier.dispose();
    _obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: _listenWhen,
      listener: _handleListenerStates,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthStepContentTemplate(
                lottieGenImage: Assets.lottie.resetPassword,
                badgeIcon: FontAwesomeIcons.arrowsRotate,
                stepTitle: AppStrings.resetPassword,
                stepSubtitle: AppStrings.resetPasswordSubTitle,
              ),
              const SizedBox(height: 15),
              ValueListenableBuilder<bool>(
                valueListenable: _obscurePasswordNotifier,
                builder: (context, obscureText, child) => AuthFormField(
                  title: AppStrings.password,
                  keyboardType: TextInputType.text,
                  verticalPadding: 20,
                  controller: _passwordController,
                  hintText: AppStrings.passwordHint,
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscureText,
                  validator: AuthValidator.validatePassword,
                  suffixIcon: ObscureTextVisibilityButton(
                    isObscured: obscureText,
                    onTap: () => _obscurePasswordNotifier.value =
                        !_obscurePasswordNotifier.value,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureConfirmPasswordNotifier,
                builder: (context, obscureText, child) => AuthFormField(
                  title: AppStrings.confirmPassword,
                  keyboardType: TextInputType.text,
                  verticalPadding: 20,
                  controller: _confirmPasswordController,
                  hintText: AppStrings.passwordHint,
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscureText,
                  validator: (value) => AuthValidator.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  suffixIcon: ObscureTextVisibilityButton(
                    isObscured: obscureText,
                    onTap: () => _obscureConfirmPasswordNotifier.value =
                        !_obscureConfirmPasswordNotifier.value,
                  ),
                ),
              ),
              AuthActionButton(
                onPressed: _handleResetPassword,
                child: BlocSelector<AuthCubit, AuthState, bool>(
                  selector: (state) => state is ResetPasswordLoading,
                  builder: (context, isLoading) => isLoading
                      ? const CustomCircularProgress()
                      : Text(
                          AppStrings.resetPassword,
                          style: context.textTheme.authButton,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _listenWhen(AuthState _, AuthState current) =>
      current is ResetPasswordSuccess || current is ResetPasswordFailure;

  void _handleListenerStates(BuildContext context, AuthState state) {
    if (state is ResetPasswordSuccess) {
      OverlayNotificationService.show(
        context: context,
        message: AppStrings.passwordResetSuccess,
        type: SnackBarType.success,
      );
      context.go(AppRouterNames.bottomNav);
    }
    if (state is ResetPasswordFailure) {
      AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
    }
  }

  void _handleResetPassword() {
    FocusManager.instance.primaryFocus?.unfocus();
    final authCubit = context.read<AuthCubit>();

    if (_formKey.currentState!.validate()) {
      authCubit.resetPasswordAndSignIn(
        oobCode: authCubit.currentOobCode ?? '',
        newPassword: _passwordController.text.trim(),
      );
    }
  }
}
