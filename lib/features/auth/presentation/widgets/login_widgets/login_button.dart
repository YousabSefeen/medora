import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;

import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../controller/cubit/login_cubit.dart';
import '../../controller/form_controllers/login_controllers.dart';
import '../../controller/states/login_state.dart';
import '../custom_button.dart';

class LoginButton extends StatelessWidget {
  final LoginControllers loginControllers;

  const LoginButton({super.key, required this.loginControllers});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, LazyRequestState>(
      selector: (state) => state.loginStatus,
      builder: (context, loginStatus) {
        _handleLoginState(context, loginStatus);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: CustomButton(
            isLoading: loginStatus == LazyRequestState.loading,
            text: AppStrings.login,
            onPressed: () => _onLoginPressed(context),
          ),
        );
      },
    );
  }

  void _onLoginPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    final cubit = context.read<LoginCubit>();

    final errorMsg = cubit.validateAndCacheInputs(loginControllers);

    if (errorMsg != null) {
      AppAlerts.showErrorSnackBar(context, errorMsg);
    } else {
      cubit.login();
    }
  }

  void _handleLoginState(BuildContext context, LazyRequestState loginStatus) {
    if (!context.mounted) return;

    Future.microtask(() {
      if (context.mounted) {
        if (loginStatus == LazyRequestState.loaded) {
          AppRouter.pushNamedAndRemoveUntil(
            context,
            AppRouterNames.bottomNavScreen,
          );
          _resetLoginStates(context);
        } else if (loginStatus == LazyRequestState.error) {
          AppAlerts.showErrorSnackBar(
            context,
            context.read<LoginCubit>().state.loginError ??
                AppStrings.unknownError,
          );
          _resetLoginStates(context);
        }
      }
    });
  }

  void _resetLoginStates(BuildContext context) => Future.microtask(() {
    if (!context.mounted) return;
    context.read<LoginCubit>().resetStates();
  });
}
