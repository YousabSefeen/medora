import 'package:dartz/dartz.dart';
import 'package:medora/core/payment_gateway_manager/stripe_payment/stripe_services.dart'
    show StripeServices;
import 'package:medora/features/payment_gateways/stripe/data/models/create_user_model.dart'
    show CreateUserModel;
import 'package:medora/features/payment_gateways/stripe/data/repository/stripe_base_repo.dart'
    show StripeBaseRepo;

import '../../../../../core/error/failure.dart' show Failure, ServerFailure;

class StripeRepository extends StripeBaseRepo {
  final StripeServices stripeServices;

  StripeRepository({required this.stripeServices});

  @override
  Future<Either<Failure, void>> makePayment({
    required int totalPrice,
    required CreateUserModel createUserModel,
  }) async {
    try {
      await stripeServices.makePayment(
        totalPrice: totalPrice,
        createUserModel: createUserModel,
      );

      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
