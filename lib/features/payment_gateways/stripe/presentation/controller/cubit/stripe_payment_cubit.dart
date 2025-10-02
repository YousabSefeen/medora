import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/features/payment_gateways/stripe/data/models/create_user_model.dart' show CreateUserModel;
import 'package:medora/features/payment_gateways/stripe/data/repository/stripe_repository.dart' show StripeRepository;
import 'package:medora/features/payment_gateways/stripe/presentation/controller/states/stripe_payment_state.dart' show StripePaymentState;

class StripePaymentCubit extends Cubit<StripePaymentState> {
  final StripeRepository stripeRepo;

  StripePaymentCubit({required this.stripeRepo})
      : super(const StripePaymentState());

  Future<void> processStripePayment({
    required int totalPrice,
    required CreateUserModel createUserModel,
  }) async {
    emit(state.copyWith(payRequestState: LazyRequestState.loading));
    final responseEither = await stripeRepo.makePayment(
      totalPrice: totalPrice,
      createUserModel: createUserModel,
    );

    responseEither.fold(
      (failure) => emit(state.copyWith(
        payErrorMessage: failure.toString(),
        payRequestState: LazyRequestState.error,
      )),
      (success) => emit(state.copyWith(
        payRequestState: LazyRequestState.loaded,
      )),
    );
  }
}
