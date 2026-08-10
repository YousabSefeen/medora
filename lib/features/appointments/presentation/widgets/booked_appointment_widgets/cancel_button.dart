import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router_names.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/common_widgets/elevated_blue_button.dart';

class CancelButton extends StatelessWidget {
  final String doctorId;
  final String appointmentId;

  const CancelButton({
    super.key,
    required this.doctorId,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedBlueButton(
      text: AppStrings.cancel,
      onPressed: () => AppAlerts.showCancelAppointmentBottomSheet(
        context: context,
        onCancelPressed: () => _closeCancelAppointmentBottomSheet(context),
        onConfirmPressed: () => _onConfirmPressed(context),
      ),
    );
  }

  void _closeCancelAppointmentBottomSheet(BuildContext context) =>
      context.pop();

  void _onConfirmPressed(BuildContext context) {
    _closeCancelAppointmentBottomSheet(context);
    _navigatorToAppointmentCancellationScreen(context);
  }

  void _navigatorToAppointmentCancellationScreen(BuildContext context) {
    context.push(
      AppRouterNames.appointmentCancellation,
      extra: {'doctorId': doctorId, 'appointmentId': appointmentId},
    );
  }
}
