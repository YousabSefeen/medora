import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/auth_action_button.dart';
import 'package:medora/features/auth/presentation/widgets/auth_step_content_template.dart';
import 'package:medora/generated/assets.dart';
import 'package:open_mail_launcher/open_mail_launcher.dart';

class CheckYourEmailStep extends StatefulWidget {
  const CheckYourEmailStep({super.key});

  @override
  State<CheckYourEmailStep> createState() => _CheckYourEmailStepState();
}

class _CheckYourEmailStepState extends State<CheckYourEmailStep> {
  final ValueNotifier<int> _secondsNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _secondsNotifier.value = 30;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsNotifier.value > 1) {
        _secondsNotifier.value--;
      } else {
        _secondsNotifier.value = 0;
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _secondsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final email = context.read<AuthCubit>().currentRecoveryEmail ?? '';
    return Column(
      children: [
        AuthStepContentTemplate(
          lottieGenImage: Assets.lottie.checkEmail,
          mainIcon: FontAwesomeIcons.envelope,
          badgeIcon: FontAwesomeIcons.check,
          stepTitle: AppStrings.checkYourEmail,
          stepSubtitle: AppStrings.secureLinkSent,
        ),
        Text(
          email,
          style: textTheme.mediumLightGreyBold.copyWith(height: 0.02),
        ),
        const SizedBox(height: 15),
        Text(
          AppStrings.redirectGuideline,
          textAlign: TextAlign.center,
          style: textTheme.smallAmberMedium,
        ),
        SizedBox(height: 40.h),
        AuthActionButton(
          heightButton: 55,
          onPressed: () => _openEmailApp(context),

          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.mail_outline, color: Colors.white),
              Text(AppStrings.openEmailApp),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        BlocListener<AuthCubit, AuthState>(
          listenWhen: _listenWhen,
          listener: _handleResendEmailListenerStates,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ValueListenableBuilder<int>(
                valueListenable: _secondsNotifier,
                builder: (context, seconds, child) {
                  final bool canResend = seconds == 0;

                  return SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          canResend
                              ? AppStrings.didntReceiveEmail
                              : '${AppStrings.resendAvailableIn} $seconds s',
                          style: textTheme.mediumWhite60Regular,
                        ),
                        if (canResend)
                          TextButton(
                            onPressed: () =>
                                _onResendPasswordResetRequested(context, email),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                AppStrings.resend,
                                style: context.textTheme.mediumWhiteBold16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleResendEmailListenerStates(BuildContext context, AuthState state) {
    if (state is ResendEmailSuccess) {
      _showSuccessNotification(context);
    }
    if (state is ResendEmailFailure) {
      _showFailureNotification(context, state.errorMessage);
    }
  }

  bool _listenWhen(_, AuthState current) =>
      current is ResendEmailSuccess || current is ResendEmailFailure;

  void _onResendPasswordResetRequested(BuildContext context, String email) {
    _startTimer();
    _sendResetPasswordRequest(context, email);
  }

  void _sendResetPasswordRequest(BuildContext context, String email) =>
      context.read<AuthCubit>().resendResetPassword(email);

  void _showSuccessNotification(BuildContext context) {
    OverlayNotificationService.show(
      context: context,
      message: AppStrings.resendVerificationSuccessWithSpamCheck,
      type: SnackBarType.success,
      duration: AppDurations.seconds_5,
    );
  }

  void _showFailureNotification(BuildContext context, String error) =>
      OverlayNotificationService.show(
        context: context,
        message: error,
        type: SnackBarType.error,
      );

  void _openEmailApp(BuildContext context) async {
    OpenMailAppResult result = await OpenMailLauncher.openMailApp();
    if (!context.mounted) return;
    if (!result.didOpen && !result.canOpen) {
      _showNoMailAppsDialog(context);
    }
  }

  void _showNoMailAppsDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: const Text(AppStrings.emailAppNotFound),
        content: const Text(AppStrings.noEmailAppDescription),
        actions: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(25, 30),
            ),
            child: const Text(AppStrings.ok),
            onPressed: () => context.pop(),
          ),
        ],
      );
    },
  );
}
