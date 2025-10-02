import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/features/appointments/data/models/picked_doctor_info_model.dart' show PickedDoctorInfoModel;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart' show AppointmentCubit;
import 'package:medora/features/appointments/presentation/widgets/custom_widgets/adaptive_action_button.dart' show AdaptiveActionButton;

import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/app_strings/app_strings.dart';
import '../controller/states/appointment_state.dart';

class BookAppointmentButton extends StatelessWidget {
  final PickedDoctorInfoModel pickedDoctorInfoModel;


  const BookAppointmentButton(
      {super.key,  required this.pickedDoctorInfoModel});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState, String?>(
      selector: (state) => state.selectedTimeSlot,
      builder: (context, selectedTimeSlot) {
        final isEnabled = selectedTimeSlot != '';

        return AdaptiveActionButton(
          title: AppStrings.bookAppointment,
          isEnabled: isEnabled,
          isLoading: false,
          onPressed: () => _bookAppointment(context),
        );
      },
    );
  }

  /// Initiates the appointment booking process
  void _bookAppointment(BuildContext context) {
    context.read<AppointmentCubit>().cachePickedDoctorInfo(pickedDoctorInfoModel);
      AppRouter.pushNamed(context, AppRouterNames.patientDetails );
  }
}

