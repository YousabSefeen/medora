import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart' show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart' show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart' show AppointmentState;

import '../../../../core/constants/app_alerts/no_internet_dialog.dart';
import '../../data/models/client_appointments_model.dart';
import '../widgets/custom_widgets/adaptive_action_button.dart';

class AppointmentCancellationScreen extends StatefulWidget {
  const AppointmentCancellationScreen({super.key});

  @override
  State<AppointmentCancellationScreen> createState() =>
      _AppointmentCancellationScreenState();
}

class _AppointmentCancellationScreenState
    extends State<AppointmentCancellationScreen> {
  String? _selectedCancellationReason;

  @override
  Widget build(BuildContext context) {
    final appointment =
        ModalRoute.of(context)!.settings.arguments as ClientAppointmentsModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBodyContent(appointment),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => AppRouter.pop(context),
            icon: const FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.black,
            ),
          ),
        ),
      ],
      title: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text(
          AppStrings.cancelAppointment,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildBodyContent(ClientAppointmentsModel appointment) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          _buildCancellationInfoCard(),
          ..._buildCancellationReasonList(),
          _buildContinueButton(appointment),
        ],
      ),
    );
  }

  Widget _buildCancellationInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.customWhite,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        AppStrings.cancellationFeedbackDescription,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
          height: 1.5,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  List<Widget> _buildCancellationReasonList() {
    return AppStrings.reasonsForCancellingList.map((reason) {
      return CancellationReasonItem(
        reason: reason,
        isSelected: _selectedCancellationReason == reason,
        onSelectionChanged: (selectedReason) {
          setState(() {
            _selectedCancellationReason = selectedReason;
          });
        },
      );
    }).toList();
  }

  Widget _buildContinueButton(ClientAppointmentsModel appointment) {
    return BlocSelector<AppointmentCubit, AppointmentState,
        dartz.Tuple2<LazyRequestState, String>>(
      selector: (state) => dartz.Tuple2(
          state.cancelAppointmentState, state.cancelAppointmentError),
      builder: (context, values) {
        _handleCancelAppointmentResponse(
            context, values.value1, values.value2);

        final isEnabled=_selectedCancellationReason != null;
        final isLoading= values.value1 == LazyRequestState.loading;


        return AdaptiveActionButton(
          title: AppStrings.confirmCancellation,
          isEnabled:  isEnabled,
          isLoading: isLoading,
          onPressed:  () => _handleCancellationConfirmation(appointment),
        );

      },
    );
  }

  void _handleCancellationConfirmation(ClientAppointmentsModel appointment) {

    // TODO: Implement cancellation logic
    if (_selectedCancellationReason != null) {
      // Process cancellation
       context.read<AppointmentCubit>().cancelAppointment(doctorId: appointment.doctorId, appointmentId: appointment.appointmentId);

    }
  }

  void _handleCancelAppointmentResponse(BuildContext context,
      LazyRequestState cancelAppointmentState, String cancelAppointmentError) {
    switch (cancelAppointmentState) {
      case LazyRequestState.lazy:
      case LazyRequestState.loading:
        break;
      case LazyRequestState.loaded:
        _handleCancelAppointmentSuccess(context);

        break;
      case LazyRequestState.error:
        _handleCancelAppointmentError(context, cancelAppointmentError);
        break;
    }
  }

  void _handleCancelAppointmentSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSuccessDialog(context);

      Future.delayed(const Duration(milliseconds: 700), () {
        if (!context.mounted) return;
        _navigateToAppointmentList(context);
      });

      _resetCancelAppointmentState(context);
    });
  }

  /// Displays success dialog after booking confirmation
  void _showSuccessDialog(BuildContext context) =>
      AppAlerts.showAppointmentSuccessDialog(
        context: context,
        message: AppStrings.successMessage,
      );

  void _navigateToAppointmentList(BuildContext context) =>
      AppRouter.pop(context);

  void _handleCancelAppointmentError(
      BuildContext context, String errorMessage) {
    Future.microtask(() {
      if (!context.mounted) return;

     AppAlerts.showCustomErrorDialog(context, errorMessage);

      _resetCancelAppointmentState(context);
    });
  }

  /// Resets the Cancel Appointment State in cubit
  void _resetCancelAppointmentState(BuildContext context) =>
      context.read<AppointmentCubit>().resetCancelAppointmentState();
}

class CancellationReasonItem extends StatelessWidget {
  final String reason;
  final bool isSelected;
  final ValueChanged<String?> onSelectionChanged;

  const CancellationReasonItem({
    super.key,
    required this.reason,
    required this.isSelected,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: Colors.grey),
      ),
      child: RadioListTile<String>(
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.all(5),
        activeColor: Colors.black,
        title: Transform.translate(
          offset: const Offset(-15, 0),
          child: Text(
            reason,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                height: 1.6,
              ),
            ),
          ),
        ),
        value: reason,
        groupValue: isSelected ? reason : null,
        onChanged: onSelectionChanged,
      ),
    );
  }
}
