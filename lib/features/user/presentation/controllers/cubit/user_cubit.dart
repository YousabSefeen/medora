import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/base_use_case/base_use_case.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/user/domain/entities/user_entity.dart';

import '../../../domain/use_cases/add_user_use_case.dart';
import '../../../domain/use_cases/get_user_data_use_case.dart';
import '../../../domain/value_objects/add_user_params.dart';
import '../states/user_states.dart';

class UserCubit extends Cubit<UserStates> {
  final AddUserUseCase _addUserUseCase;
  final GetUserDataUseCase _getUserDataUseCase;

  UserCubit({
    required this._addUserUseCase,
    required this._getUserDataUseCase,
  }) : super(UserProfileInitial());
  UserEntity? currentUser;
  Future<void> addUser({required AddUserParams params}) async {
    AppLogger.info('addUser Open');
    // final providerType = params.authProviderType;
    emit(AddUserLoading());
    final result = await _addUserUseCase.call(params);

    result.fold(
      (failure) => emit(AddUserFailure(failure.errorMessage)),
      (_) => emit(AddUserSuccess()),
    );
  }

  Future<void> getUserData() async {
    AppLogger.info('addUser Open');
    // final providerType = params.authProviderType;
    emit(GetUserDataLoading());
    final result = await _getUserDataUseCase.call(const NoParams());

    result.fold(
      (failure) {
        AppLogger.error('failure:  ${failure.errorMessage}');
        emit(GetUserDataFailure(failure.errorMessage));
      },
      (UserEntity userEntity) {
        currentUser=userEntity;
        AppLogger.info('userEntity:  $userEntity');
        emit(GetUserDataSuccess(userEntity:userEntity));
      },
    );
  }
}
