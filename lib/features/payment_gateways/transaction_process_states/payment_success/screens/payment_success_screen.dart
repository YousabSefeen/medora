import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_dimensions/app_dimensions.dart'
    show AppDimensions;
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/di/injection_container.dart' show sl;
import 'package:medora/core/enum/appointment_status.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/core/enum/payment_gateways_types.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/confirm_pending_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/states/confirm_pending_appointment_state.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/appointment_details_success_card.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_check_icon.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_dashed_line_divider.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_payment_success_message.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/payment_success_fab_section.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final PaymentGatewaysTypes paymentMethod;
  final PaymobTransactionDataResultModel? paymobResponse;
  final String? paypalEmail;

  const PaymentSuccessScreen({
    super.key,
    required this.paymentMethod,
    this.paymobResponse,
    this.paypalEmail,
  });

  @override
  Widget build(BuildContext context) {
    final patientCubit = context.read<PatientCubit>();
    final bookCubit = context.read<BookAppointmentCubit>();

    final appointmentEntity = bookCubit.createEntityFromPatientData(
      name: patientCubit.patientName,
      age: patientCubit.patientAge,
      gender: patientCubit.patientGender,
      problem: patientCubit.patientProblem,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onBackPress(context, didPop),
      child: BlocProvider<ConfirmPendingAppointmentCubit>(
        create: (context) =>
            sl<ConfirmPendingAppointmentCubit>()
              ..confirmPendingAppointment(entity: appointmentEntity),
        child: Scaffold(
          appBar: AppBar(backgroundColor: AppColors.lightPeriwinkle),
          backgroundColor: AppColors.lightPeriwinkle,
          floatingActionButton: PaymentSuccessFABSection(
            onDonePressed: () => _navigatorToUpcomingAppointmentsList(context),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SafeArea(
            child:
                BlocBuilder<
                  ConfirmPendingAppointmentCubit,
                  ConfirmPendingAppointmentState
                >(
                  buildWhen: (prev, curr) =>
                      prev.confirmAppointmentState !=
                      curr.confirmAppointmentState,
                  builder: (context, state) => _mapStateToWidget(state),
                ),
          ),
        ),
      ),
    );
  }

  void _navigatorToUpcomingAppointmentsList(BuildContext context) {
    context.read<BottomNavCubit>().changeTabIndex(1);
    context.go(AppRouterNames.bottomNav);

    final bookCubit = context.read<BookAppointmentCubit>();

    final patientCubit = context.read<PatientCubit>();
    context.read<UpcomingAppointmentsCubit>().addAppointmentLocally(
      clientAppointment: ClientAppointmentsEntity(
        isReviewed: false,
        reviewId: null,
        clientId: FirebaseAuth.instance.currentUser!.uid,
        doctorId: bookCubit.bookingDetails.doctorEntity.doctorId!,
        appointmentId: bookCubit.state.appointmentId,
        patientName: patientCubit.patientName,
        patientGender: patientCubit.patientGender,
        patientAge: patientCubit.patientAge,
        patientProblem: patientCubit.patientProblem,
        appointmentDate: bookCubit.bookingDetails.appointmentDate,
        appointmentTime: bookCubit.bookingDetails.appointmentTime,
        appointmentStatus: AppointmentStatus.confirmed.name,
        doctorEntity: bookCubit.bookingDetails.doctorEntity,
      ),
    );
  }

  Widget _mapStateToWidget(ConfirmPendingAppointmentState state) {
    return switch (state.confirmAppointmentState) {
      LazyRequestState.loading => const CustomCircularProgress(),
      LazyRequestState.loaded => const _PaymentSuccessContent(),
      LazyRequestState.error => _ErrorView(
        message: state.confirmAppointmentError!,
      ),
      _ => const SizedBox.shrink(),
    };
  }

  void _onBackPress(BuildContext context, bool didPop) {
    if (!didPop) {
      _navigatorToUpcomingAppointmentsList(context);
    }
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${AppStrings.errorMessagePrefix} $message',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

class _PaymentSuccessContent extends StatelessWidget {
  const _PaymentSuccessContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.horizontalPadding20,
      child: Container(
        width: double.infinity,
        height: context.screenHeight * 0.7,
        decoration: _buildShapeDecoration(),
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            children: [
              CustomCheckIcon(),
              CustomPaymentSuccessMessage(),
              SizedBox(height: 10),
              CustomDashedLineDivider(),
              AppointmentDetailsSuccessCard(),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  ShapeDecoration _buildShapeDecoration() => ShapeDecoration(
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
