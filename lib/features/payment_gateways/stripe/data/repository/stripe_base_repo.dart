import 'package:dartz/dartz.dart';

import 'package:medora/features/payment_gateways/stripe/data/models/create_user_model.dart' show CreateUserModel;

import '../../../../../core/error/failure.dart' show Failure;



abstract class StripeBaseRepo {
  Future<Either<Failure, void>> makePayment({
    required int totalPrice,
    required CreateUserModel createUserModel,
  });
}
