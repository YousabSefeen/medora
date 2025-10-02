import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/features/auth/presentation/widgets/register_widgets/register_error_snack_bar_content.dart' show RegisterErrorSnackBarContent;
import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../controller/cubit/register_cubit.dart';
import '../../controller/form_controllers/register_controllers.dart';
import '../../controller/states/register_state.dart';
import '../custom_button.dart';

class RegisterButton extends StatelessWidget {
  final RegisterControllers registerControllers;

  const RegisterButton({super.key, required this.registerControllers});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, LazyRequestState>(
      selector: (state) => state.registerState,
      builder: (context, registerState) {
        _handleRegisterState(context, registerState);
        return CustomButton(
          text: AppStrings.registerNow,
          isLoading: registerState == LazyRequestState.loading,
          onPressed: () => onRegisterPressed(context),
        );
      },
    );
  }

  void _handleRegisterState(BuildContext context, LazyRequestState state) {
    if (state == LazyRequestState.loaded) {
      _navigateToVerification(context);
    } else if (state == LazyRequestState.error) {
      final errorMessage =
          context.read<RegisterCubit>().state.error ?? AppStrings.unknownError;
      _showError(context, errorMessage);
    }
  }

  void _navigateToVerification(BuildContext context) =>
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppRouter.pushNamed(context, AppRouterNames.bottomNavScreen);
        _resetRegisterStates(context);
      });

  void _showError(BuildContext context, String errorMessage) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (errorMessage == AppStrings.emailAlreadyInUseError) {
        AppAlerts.showRegisterErrorSnackBar(
          context: context,
          errorMessage: errorMessage,
          content: RegisterErrorSnackBarContent(
            errorMessage: errorMessage,
            userEmail: registerControllers.emailController.text,
          ),
        );
      } else {
        AppAlerts.showErrorSnackBar(context, errorMessage);
      }
      _resetRegisterStates(context);
    });
  }

  void _resetRegisterStates(BuildContext context) => Future.microtask(() {
        if (!context.mounted) return;
        context.read<RegisterCubit>().resetStates();
      });

  void onRegisterPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final cubit = context.read<RegisterCubit>();
    final errorMsg = cubit.validateAndCacheInputs(registerControllers);

    if (errorMsg != null) {
      AppAlerts.showErrorSnackBar(context, errorMsg);
    } else {
      cubit.register();
    }
  }
}
