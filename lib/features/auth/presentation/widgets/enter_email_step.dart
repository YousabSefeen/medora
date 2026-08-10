import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/form_controllers/auth_validator.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:medora/features/auth/presentation/widgets/auth_step_content_template.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';
import 'package:medora/generated/assets.dart';

class EnterEmailStep extends StatefulWidget {
  const EnterEmailStep({super.key});

  @override
  State<EnterEmailStep> createState() => _EnterEmailStepState();
}

class _EnterEmailStepState extends State<EnterEmailStep> {
  late final TextEditingController _emailController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController(
      text: context.read<AuthCubit>().currentRecoveryEmail,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AuthStepContentTemplate(
              lottieGenImage: Assets.lottie.forgetPassword,
              badgeIcon: FontAwesomeIcons.question,
              stepTitle: AppStrings.forgotPassword,
              stepSubtitle: AppStrings.forgotPasswordSubTitle,
            ),
            const SizedBox(height: 15),
            AuthFormField(
              title: AppStrings.email,
              controller: _emailController,
              hintText: AppStrings.emailHint,
              prefixIcon: Icons.mail_outline,
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              verticalPadding: 20,
              validator: AuthValidator.validateEmail,
            ),
            AuthActionButton(
              heightButton: 55,
              onPressed: _onSubmit,

              child: BlocSelector<AuthCubit, AuthState, bool>(
                selector: (state) => state is SendPasswordResetEmailLoading,
                builder: (context, isLoading) => isLoading
                    ? const CustomCircularProgress()
                    : const Text(AppStrings.continueButton),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
    }
  }
}
