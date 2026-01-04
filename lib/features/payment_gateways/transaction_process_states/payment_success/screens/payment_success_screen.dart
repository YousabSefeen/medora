import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, ReadContext, BlocBuilder;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/core/enum/payment_gateways_types.dart'
    show PaymentGatewaysTypes;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart'
    show BookAppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/confirm_pending_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/patient_cubit.dart' show PatientCubit;
import 'package:medora/features/appointments/presentation/controller/states/confirm_pending_appointment_state.dart'
    show ConfirmPendingAppointmentState;
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataResultModel;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/appointment_details_success_card.dart'
    show AppointmentDetailsSuccessCard;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/bottom_action_button_section.dart'
    show BottomActionButtonSection;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_check_icon.dart'
    show CustomCheckIcon;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_dashed_line_divider.dart'
    show CustomDashedLineDivider;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_payment_success_message.dart'
    show CustomPaymentSuccessMessage;

class PaymentSuccessScreen extends StatelessWidget {
  final PaymentGatewaysTypes paymentMethod;
  final PaymobTransactionDataResultModel? paymobResponseModel;
  final String? paypalPayerEmail;

  const PaymentSuccessScreen({
    super.key,
    required this.paymentMethod,
    this.paymobResponseModel,
    this.paypalPayerEmail,
  });

  @override
  Widget build(BuildContext context) {
    print('PaymentSuccessScreen.buildooooooooooooooooooooo');
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _navigateToDoctorList(context);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffC0C9EE),
        appBar: AppBar(backgroundColor: Colors.transparent),
        bottomNavigationBar: const BottomActionButtonSection(),
        body: BlocProvider(
          create: (context) => serviceLocator<ConfirmPendingAppointmentCubit>()
            ..confirmPendingAppointment(
              doctorId: context
                  .read<BookAppointmentCubit>()
                  .appointmentDataView
                  .doctorEntity
                  .doctorId!,
              appointmentId: context.read<BookAppointmentCubit>().appointmentId,
              appointmentDate: context
                  .read<BookAppointmentCubit>()
                  .appointmentDataView
                  .appointmentDate,
              appointmentTime: context
                  .read<BookAppointmentCubit>()
                  .appointmentDataView
                  .appointmentTime,
              patientName: context
                  .read<PatientCubit>()
                  .getPatientData
                  .nameController
                  .text,
              patientAge: context
                  .read<PatientCubit>()
                  .getPatientData
                  .ageController
                  .text,
              patientGender: context.read<PatientCubit>().getGender,
              patientProblem: context
                  .read<PatientCubit>()
                  .getPatientData
                  .problemController
                  .text,
            ),

          child:
              BlocBuilder<
                ConfirmPendingAppointmentCubit,
                ConfirmPendingAppointmentState
              >(
                builder: (context, state) {
                  switch (state.confirmAppointmentState) {
                    case LazyRequestState.lazy:
                      return const Center(child: Text('LazyRequestState.lazy'));
                    case LazyRequestState.loading:
                      return const Center(child: CircularProgressIndicator());

                    case LazyRequestState.loaded:
                      return const _PaymentSuccessBody();

                    case LazyRequestState.error:
                      return Center(
                        child: Text(
                          'An Error Occurred ${state.confirmAppointmentError}',
                        ),
                      );
                  }
                },
              ),
        ),
      ),
    );
  }

  void _navigateToDoctorList(BuildContext context) =>
      AppRouter.pushAndRemoveUntil(context, const BottomNavScreen());
}

class _PaymentSuccessBody extends StatelessWidget {
  const _PaymentSuccessBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _buildShapeDecoration(),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              CustomCheckIcon(),
              CustomPaymentSuccessMessage(),
              SizedBox(height: 10),
              CustomDashedLineDivider(),
              AppointmentDetailsSuccessCard(),
            ],
          ),
        ),
      ),
    );
  }

  ShapeDecoration _buildShapeDecoration() {
    return ShapeDecoration(
      color: AppColors.softBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        side: const BorderSide(color: AppColors.white),
      ),
    );
  }
}
