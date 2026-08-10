import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';

class VerificationAndResetScreen extends StatefulWidget {
  final String email;
  final String verificationId;

  const VerificationAndResetScreen({
    super.key,
    required this.email,
    required this.verificationId,
  });

  @override
  State<VerificationAndResetScreen> createState() =>
      _VerificationAndResetScreenState();
}

class _VerificationAndResetScreenState
    extends State<VerificationAndResetScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.verifyAndResetTitle),
        backgroundColor: Colors.indigo,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(AppStrings.passwordResetSuccessMessage),
                backgroundColor: Colors.green,
              ),
            );
            // Handle Navigator When ResetPasswordSuccess state
          } else if (state is ResetPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${AppStrings.errorPrefix}${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${AppStrings.verifyingEmailPrefix}${widget.email}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: AppStrings.otpCodeLabel,
                      prefixIcon: Icon(Icons.lock_clock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return AppStrings.otpValidationWarning;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: AppStrings.newPasswordLabel,
                      prefixIcon: Icon(Icons.lock_open),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return AppStrings.passwordLengthValidation;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .verifyOtpAndUpdatePassword(
                                    email: widget.email,
                                    verificationId: widget.verificationId,
                                    smsCode: _otpController.text.trim(),
                                    newPassword: _newPasswordController.text
                                        .trim(),
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CustomCircularProgress(),
                          )
                        : const Text(
                            AppStrings.updateAndConfirmButton,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
