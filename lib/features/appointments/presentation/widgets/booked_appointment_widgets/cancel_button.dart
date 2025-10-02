

import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart' show AppAlerts;
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_routes/app_router_names.dart' show AppRouterNames;

import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/constants/common_widgets/elevated_blue_button.dart';
import '../../../data/models/client_appointments_model.dart';

class CancelButton extends StatelessWidget {
  final ClientAppointmentsModel appointment;
  const CancelButton({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ElevatedBlueButton(
      text: AppStrings.cancel,
      onPressed: () => AppAlerts.showCancelAppointmentBottomSheet(
          context: context,
          onCancelPressed: () => AppRouter.pop(context),
          onConfirmPressed: () {
            AppRouter.pop(context);
            AppRouter.pushNamed(
              context,
              AppRouterNames.appointmentCancellation,
              arguments: appointment,
            );
          }),
    );
  }
}
