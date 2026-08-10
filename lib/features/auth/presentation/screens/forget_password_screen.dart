import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/extensions/context_extension.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/auth/presentation/controller/states/auth_state.dart';
import 'package:medora/features/auth/presentation/widgets/check_your_email_step.dart';
import 'package:medora/features/auth/presentation/widgets/enter_email_step.dart';
import 'package:medora/features/auth/presentation/widgets/reset_password_step.dart';
import 'package:medora/features/auth/presentation/widgets/stepper_indicator.dart';
import 'package:medora/features/shared/presentation/widgets/custom_circular_progress.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? email;
  final String? oobCode;

  const ForgotPasswordScreen({super.key, this.email, this.oobCode});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final PageController _pageController;
  late final ValueNotifier<int> _currentPageNotifier;
  final int _totalSteps = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentPageNotifier = ValueNotifier<int>(0);

    final authCubit = context.read<AuthCubit>();
    if (widget.email != null) authCubit.updateRecoveryEmail(widget.email!);
    if (widget.oobCode != null) {
      authCubit.updateOobCode(widget.oobCode!);
      authCubit.fetchEmailFromCode(oobCode: widget.oobCode!);
    }
  }

  @override
  void didUpdateWidget(covariant ForgotPasswordScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.oobCode != null && widget.oobCode != oldWidget.oobCode) {
      context.read<AuthCubit>().updateOobCode(widget.oobCode!);
      context.read<AuthCubit>().fetchEmailFromCode(oobCode: widget.oobCode!);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) async {
    await context.ensureKeyboardIsClosed();
    if (context.mounted) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          pageIndex,
          duration: AppDurations.milliseconds_400,
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.darkBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        leading: IconButton(
          onPressed: () => _currentPageNotifier.value > 0
              ? _navigateToPage(_currentPageNotifier.value - 1)
              : context.go(AppRouterNames.signIn),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: _listenWhen,
        listener: _handleListenerStates,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.darkBlue, AppColors.blueGray],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      ValueListenableBuilder<int>(
                        valueListenable: _currentPageNotifier,
                        builder: (context, pageIndex, _) => StepperIndicator(
                          activeIndex: pageIndex,
                          totalSteps: _totalSteps,
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (index) =>
                              _currentPageNotifier.value = index,
                          children: const [
                            EnterEmailStep(),
                            CheckYourEmailStep(),
                            ResetPasswordStep(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (prev, curr) =>
                  curr is FetchEmailFromCodeLoading ||
                  prev is FetchEmailFromCodeLoading,
              builder: (context, state) {
                if (state is FetchEmailFromCodeLoading) {
                  return const Material(
                    color: Colors.black45,
                    child: CustomCircularProgress(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleListenerStates(BuildContext context, AuthState state) {
    if (state is FetchEmailFromCodeSuccess) {
      _navigateToPage(2);
    }
    if (state is FetchEmailFromCodeFailure) {
      _navigateToPage(0);
      AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
    }
    if (state is SendPasswordResetEmailSuccess) {
      _navigateToPage(1);
    }
    if (state is SendPasswordResetEmailFailure) {
      AppAlerts.showAuthErrorSnackBar(context, state.errorMessage);
    }
  }

  bool _listenWhen(_, AuthState curr) =>
      curr is FetchEmailFromCodeSuccess ||
      curr is FetchEmailFromCodeFailure ||
      curr is SendPasswordResetEmailSuccess ||
      curr is SendPasswordResetEmailFailure;
}
