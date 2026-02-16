import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_dimensions/app_dimensions.dart'
    show AppDimensions;
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/core/enum/payment_gateways_types.dart';
import 'package:medora/core/services/server_locator.dart';
import 'package:medora/features/appointments/domain/entities/book_appointment_entity.dart'
    show BookAppointmentEntity;
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/confirm_pending_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/patient_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/states/confirm_pending_appointment_state.dart';
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/appointment_details_success_card.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/bottom_action_button_section.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_check_icon.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_dashed_line_divider.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/widgets/custom_payment_success_message.dart';

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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          _handleBackNavigation(didPop, context),
      child: Scaffold(
        backgroundColor: AppColors.lightPeriwinkle,
        appBar: _buildAppBar(),
        bottomNavigationBar: const BottomActionButtonSection(),
        body: _buildBlocProvider(context),
      ),
    );
  }

  // Private Methods
  void _handleBackNavigation(bool didPop, BuildContext context) {
    if (!didPop) {
      _navigateToHomeScreen(context);
    }
  }

  void _navigateToHomeScreen(BuildContext context) {
    AppRouter.pushAndRemoveUntil(context, const BottomNavScreen());
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBlocProvider(BuildContext context) {
    return BlocProvider<ConfirmPendingAppointmentCubit>(
      create: (context) => _createConfirmAppointmentCubit(context),
      child: _buildBlocConsumer(),
    );
  }

  ConfirmPendingAppointmentCubit _createConfirmAppointmentCubit(
    BuildContext context,
  ) {
    final cubit = serviceLocator<ConfirmPendingAppointmentCubit>();
    final appointmentData = _extractAppointmentData(context);

    cubit.confirmPendingAppointment(entity: appointmentData);

    return cubit;
  }

  BookAppointmentEntity _extractAppointmentData(BuildContext context) {
    final bookAppointmentCubit = context.read<BookAppointmentCubit>();
    final patientCubit = context.read<PatientCubit>();
    final patientData = patientCubit.getPatientData;

    return BookAppointmentEntity(
      doctorId: bookAppointmentCubit.appointmentDataView.doctorEntity.doctorId!,
      appointmentId: bookAppointmentCubit.appointmentId,
      appointmentDate: bookAppointmentCubit.appointmentDataView.appointmentDate,
      appointmentTime: bookAppointmentCubit.appointmentDataView.appointmentTime,
      patientName: patientData.nameController.text,
      patientAge: patientData.ageController.text,
      patientGender: patientCubit.getGender,
      patientProblem: patientData.problemController.text,
    );
  }

  Widget _buildBlocConsumer() {
    return BlocBuilder<
      ConfirmPendingAppointmentCubit,
      ConfirmPendingAppointmentState
    >(builder: (context, state) => _buildStateContent(context, state));
  }

  Widget _buildStateContent(
    BuildContext context,
    ConfirmPendingAppointmentState state,
  ) {
    switch (state.confirmAppointmentState) {
      case LazyRequestState.lazy:
        return _buildLazyState();
      case LazyRequestState.loading:
        return _buildLoadingState();
      case LazyRequestState.loaded:
        return const _PaymentSuccessContent();
      case LazyRequestState.error:
        return _buildErrorState(state);
    }
  }

  Widget _buildLazyState() {
    return const SizedBox.shrink();
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(ConfirmPendingAppointmentState state) {
    return Center(
      child: Text(
        '${AppStrings.errorMessagePrefix} ${state.confirmAppointmentError}',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

// Content Widget
class _PaymentSuccessContent extends StatelessWidget {
  const _PaymentSuccessContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.horizontalPadding20,
      child: Container(
        width: double.infinity,
        height: double.infinity,
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
              SizedBox(height: 16),
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
