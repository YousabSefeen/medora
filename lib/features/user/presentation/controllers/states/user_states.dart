import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';

sealed class UserStates extends Equatable {
  const UserStates();

  @override
  List<Object?> get props => [];
}

final class UserProfileInitial extends UserStates {}

final class AddUserLoading extends UserStates {}

final class AddUserSuccess extends UserStates {
  //final List<AddUserSuccess> reviews;

  //const AddUserSuccess(this.reviews);

  // @override
  // List<Object?> get props => [reviews];
}

final class AddUserFailure extends UserStates {
  final String message;

  const AddUserFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//
final class GetUserDataInitial extends UserStates {}

final class GetUserDataLoading extends UserStates {}

final class GetUserDataSuccess extends UserStates {
  final UserEntity userEntity;

  const GetUserDataSuccess({required this.userEntity});
  @override
  List<Object > get props => [userEntity];
}

final class GetUserDataFailure extends UserStates {
  final String message;

  const GetUserDataFailure(this.message);

  @override
  List<Object?> get props => [message];
}

//
final class AddReviewLoading extends UserStates {}

final class AddReviewSuccess extends UserStates {}

final class AddReviewFailure extends UserStates {
  final String message;

  const AddReviewFailure(this.message);

  @override
  List<Object?> get props => [message];
}
