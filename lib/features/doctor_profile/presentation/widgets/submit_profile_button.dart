import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;
import 'package:medora/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart'
    show DoctorProfileState;

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/form_controllers/doctor_fields_controllers.dart';

class SubmitProfileButton extends StatelessWidget {
  final DoctorFieldsControllers controllers;

  const SubmitProfileButton({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
      listenWhen: (previous, current) =>
          previous.doctorProfileState != current.doctorProfileState,
      buildWhen: (previous, current) =>
          previous.doctorProfileState != current.doctorProfileState,
      listener: (context, state) => _handleDoctorProfileState(state, context),
      builder: (context, state) {
        final isLoading = state.doctorProfileState == LazyRequestState.loading;
        return AdaptiveActionButton(
          bottomHeight: 55,
          isEnabled: true,
          isLoading: isLoading,
          title: AppStrings.submitProfileBtn,

          onPressed: () => _onSavePressed(context),
        );
      },
    );
  }

  void _onSavePressed(BuildContext context) {
    _dismissKeyboard();
    // Fetches the real-time state directly from the Cubit to avoid any stale state
    // issues caused by buildWhen optimizations at the exact moment of pressing.
    final currentPath = context
        .read<DoctorProfileCubit>()
        .state
        .pickedImagePath;
    if (currentPath.isEmpty) {
      _showProfilePhotoRequiredAlert(context);
    } else {
      context.read<DoctorProfileCubit>().validateInputsAndSubmitProfile(
        controllers,
      );
    }
  }

  void _showProfilePhotoRequiredAlert(BuildContext context) =>
      OverlayNotificationService.show(
        context: context,
        message: AppStrings.profilePhotoRequired,
        type: SnackBarType.error,
        snackBarBehaviorType: SnackBarBehaviorType.top,
      );

  void _handleDoctorProfileState(
    DoctorProfileState state,
    BuildContext context,
  ) {
    if (state.doctorProfileState == LazyRequestState.loaded) {
      _showSuccessDialogAfterDelay(context);
      _navigateToDoctorListAfterDelay(context);
    } else if (state.doctorProfileState == LazyRequestState.error) {
      AppAlerts.showCustomErrorDialog(
        context,
        state.doctorProfileError ?? AppStrings.defaultErrorMessage,
      );
    }
  }

  // Dismisses the keyboard if it's currently open.
  void _dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  // - Shows success dialog
  void _showSuccessDialogAfterDelay(BuildContext context) =>
      Future.delayed(AppDurations.milliseconds_600, () {
        if (!context.mounted) return;
        AppAlerts.showAppointmentSuccessDialog(
          context: context,
          message: AppStrings.profileSubmittedSuccess,
        );
      });

  // - Navigates to doctor list screen
  void _navigateToDoctorListAfterDelay(BuildContext context) =>
      Future.delayed(AppDurations.seconds_2, () {
        if (!context.mounted) return;
        context.go(AppRouterNames.bottomNav);
      });
}
