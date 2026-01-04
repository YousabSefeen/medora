import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/confirm_pending_appointment_cubit.dart'
    show ConfirmPendingAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart' show TimeSlotCubit;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart'
    show PaymentSuccessScreen;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/appointment_details_widget.dart'
    show AppointmentDetailsWidget;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/doctor_info.dart'
    show DoctorInfo;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/payment_method_details.dart'
    show PaymentMethodDetails;

class AppointmentDetailsSuccessCard extends StatelessWidget {
  const AppointmentDetailsSuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorModel = context
        .read<BookAppointmentCubit>()
        .appointmentDataView
        .doctorEntity;
    final selectedTimeSlot = context.read<TimeSlotCubit>().selectedTimeSlot;
    final selectedDateFormatted = context
        .read<TimeSlotCubit>()
        .selectedDateFormatted;

    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            DoctorInfo(
              doctorImage: doctorModel.imageUrl,
              doctorName: doctorModel.name,
            ),
            AppointmentDetailsWidget(
              label: AppStrings.locationLabel,
              value: doctorModel.location,
            ),
            AppointmentDetailsWidget(
              label:AppStrings.dateLabel,
              value: selectedDateFormatted,
            ),
            AppointmentDetailsWidget(label: 'Time', value: selectedTimeSlot),
            Text(
              AppStrings.paymentMethod,
              style: Theme.of(context).textTheme.latoSemiBoldDark,
            ),

            PaymentMethodDetails(
              paymentMethod:
                  (context.findAncestorWidgetOfExactType<PaymentSuccessScreen>()
                          as PaymentSuccessScreen)
                      .paymentMethod,
            ),
          ],
        ),
      ),
    );
  }
}
