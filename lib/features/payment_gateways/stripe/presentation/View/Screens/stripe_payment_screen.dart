import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_routes/app_router.dart' show AppRouter;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/common_widgets/custom_loading_text.dart' show CustomLoadingText;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/enum/payment_gateways_types.dart' show PaymentGatewaysTypes;
import 'package:medora/core/payment_gateway_manager/payment_helper/payment_navigation_helper.dart' show PaymentNavigationHelper;
import 'package:medora/core/payment_gateway_manager/stripe_payment/stripe_dummy_data_service.dart' show StripeDummyDataService;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/payment_gateways/stripe/presentation/controller/cubit/stripe_payment_cubit.dart' show StripePaymentCubit;
import 'package:medora/features/payment_gateways/stripe/presentation/controller/states/stripe_payment_state.dart' show StripePaymentState;
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart' show PaymentSuccessScreen;



class StripePaymentScreen extends StatelessWidget {
  const StripePaymentScreen({super.key});


  void _popWithPaymentCancelledResult(BuildContext context)=> PaymentNavigationHelper.popWithPaymentCancelledResult(context);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
      !didPop ? _popWithPaymentCancelledResult( context) : null,
      child: Scaffold(
          appBar: AppBar(
            title:   const Text(AppStrings.stripePayment),
            leading: BackButton(onPressed:()=> _popWithPaymentCancelledResult(context),
            ),
          ),
          body: BlocProvider(
            create: (context) => serviceLocator<StripePaymentCubit>()
              ..processStripePayment(
                  totalPrice: 100, createUserModel: StripeDummyDataService.createUserModel,),
            child: BlocSelector<StripePaymentCubit, StripePaymentState,
                dartz.Tuple2<LazyRequestState, String>>(
              selector: (state) =>dartz.Tuple2(state.payRequestState, state.payErrorMessage) ,
              builder: (context, values) {
                _handlePaymentStates(context,values.value1,values.value2);
                return const Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomLoadingText(),
                );
              },
            ),
          )),
    );
  }

  void _handlePaymentStates(BuildContext context,LazyRequestState payState,String errorMessage) {
    Future.microtask((){
      if(!context.mounted) return;
      switch (payState) {
        case LazyRequestState.lazy:
        case LazyRequestState.loading:
          break;
        case LazyRequestState.loaded:
          _handlePaymentSuccess(context);
          break;
        case LazyRequestState.error:
          _handlePaymentError(context,errorMessage);
          break;
      }
    });

  }

  void _handlePaymentSuccess(BuildContext context) => AppRouter.pushAndRemoveUntil(
        context,
        const PaymentSuccessScreen(
          paymentMethod: PaymentGatewaysTypes.stripe,
        ),
      );

  void _handlePaymentError(BuildContext context, String errorMessage) =>
      Navigator.pop(context, errorMessage);
}
