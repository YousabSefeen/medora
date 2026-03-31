import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart'
    show AppTextStyles;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/appointments/presentation/controller/cubit/cancel_appointment_cubit.dart'
    show CancelAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart'
    show CancelledAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart'
    show UpcomingAppointmentsCubit;
import 'package:medora/features/appointments/presentation/controller/states/cancel_appointment_state.dart'
    show CancelAppointmentState;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart'
    show AdaptiveActionButton;

class AppointmentCancellationScreen extends StatelessWidget {
  final String doctorId;
  final String appointmentId;

  const AppointmentCancellationScreen({
    super.key,
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _CancelAppBar(),
      body: BlocProvider(
        create: (context) => serviceLocator<CancelAppointmentCubit>(),
        child: BlocListener<CancelAppointmentCubit, CancelAppointmentState>(
          listenWhen: (prev, curr) => prev.requestState != curr.requestState,
          listener: (context, state) =>
              _onStateChangeListener(context, state, appointmentId),
          child: _CancellationBody(
            doctorId: doctorId,
            appointmentId: appointmentId,
          ),
        ),
      ),
    );
  }

  void _onStateChangeListener(
    BuildContext context,
    CancelAppointmentState state,
    String appointmentId,
  ) {
    if (state.requestState == LazyRequestState.loaded) {
      _handleSuccess(context, appointmentId);
    } else if (state.requestState == LazyRequestState.error) {
      _handleError(context, state.failureMessage);
    }
  }

  Future<void> _handleSuccess(
    BuildContext context,
    String appointmentId,
  ) async {
    context.read<UpcomingAppointmentsCubit>().removeAppointmentLocally(
      appointmentId: appointmentId,
    );
    context.read<CancelledAppointmentsCubit>().refreshData();

    await AppAlerts.showAppointmentSuccessDialog(
      context: context,
      message: AppStrings.cancelledSuccessfullyMsg,
    );

    if (context.mounted) Navigator.pop(context);
  }

  void _handleError(BuildContext context, String message) {
    AppAlerts.showCustomErrorDialog(context, message);
    context.read<CancelAppointmentCubit>().resetCancelAppointmentState();
  }
}

class _CancelAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: Colors.white,

    title: Text(
      AppStrings.cancelAppointment,
      style: _textStyle(context).copyWith(
        color: Colors.black,
        fontSize: _textStyle(context).fontSize! - 2,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.black),
      ),
    ],
  );

  TextStyle _textStyle(BuildContext context) =>
      Theme.of(context).appBarTheme.titleTextStyle!;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CancellationBody extends StatelessWidget {
  final String doctorId;
  final String appointmentId;

  const _CancellationBody({
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        children: [
          _buildInfoCard(context),
          SizedBox(height: 20.h),
          _ReasonsListSection(),
          SizedBox(height: 30.h),
          _SubmitButton(doctorId: doctorId, appointmentId: appointmentId),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 15.w),
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: AppColors.customWhite,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Text(
      AppStrings.cancellationFeedbackDescription,
      style: context.textTheme.smallOrangeMedium,
    ),
  );
}

class _ReasonsListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CancelAppointmentCubit, CancelAppointmentState, String>(
      selector: (state) => state.selectedCancellationReason,
      builder: (context, selectedReason) {
        return RadioGroup<String>(
          groupValue: selectedReason,
          onChanged: (val) => context
              .read<CancelAppointmentCubit>()
              .setCancellationReason(val!),
          child: Column(
            spacing: 12.h,
            children: AppStrings.reasonsForCancellingList.map((reason) {
              return _CancellationReasonItem(
                reason: reason,
                isSelected: selectedReason == reason,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _CancellationReasonItem extends StatelessWidget {
  final String reason;
  final bool isSelected;

  const _CancellationReasonItem({
    required this.reason,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      color: isSelected ? AppColors.customWhite : Colors.white,
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isSelected ? AppColors.lightBlue : Colors.black26,
        ),
      ),
      child: RadioListTile<String>(
        value: reason,
        horizontalTitleGap: 1.5,
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.all(5.r),
        activeColor: AppColors.lightBlue,
        title: Text(
          reason,
          style: context.textTheme.numbersStyle.copyWith(
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String doctorId;
  final String appointmentId;

  const _SubmitButton({required this.doctorId, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CancelAppointmentCubit, CancelAppointmentState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: AdaptiveActionButton(
            title: AppStrings.confirmCancellation,
            isEnabled: state.selectedCancellationReason.isNotEmpty,
            isLoading: state.requestState == LazyRequestState.loading,
            onPressed: () =>
                context.read<CancelAppointmentCubit>().cancelAppointment(
                  doctorId: doctorId,
                  appointmentId: appointmentId,
                ),
          ),
        );
      },
    );
  }
}
