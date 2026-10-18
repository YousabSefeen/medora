import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/gemini/presentation/controllers/cubit/gemini_cubit.dart';
import 'package:medora/features/gemini/presentation/controllers/states/gemini_state.dart';

class GeminiChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeminiChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: AppColors.customWhite,
      title: Text(
        AppStrings.chatAppBarTitle,
        style: context.textTheme.appBarTitleStyle,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: BlocConsumer<GeminiCubit, GeminiState>(
          listener: (BuildContext context, GeminiState state) =>
              _handleErrorState(state, context),
          builder: (BuildContext context, GeminiState state) =>
              state.requestState == LazyRequestState.loading
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(4),
                  child: LinearProgressIndicator(
                    color: Colors.amber,
                    backgroundColor: AppColors.red,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  void _handleErrorState(GeminiState state, BuildContext context) {
    if (state.requestState == LazyRequestState.error) {
      if (state.requestStateError.contains('429')) {
        AppAlerts.showGeminiErrorDialog(
          context: context,
          errorMessage:
              'You have exceeded the allowed number of orders, please wait a moment.',
        );
      } else if (state.requestStateError.contains('503')) {
        AppAlerts.showGeminiErrorDialog(
          context: context,
          errorMessage:
              'Service servers are currently busy, please try again later.',
          showCloseButtonOnly: false,
          onRetryNow: () {},
        );
      } else if (state.requestStateError.contains('network_error')) {
        AppAlerts.showGeminiErrorDialog(
          context: context,
          errorMessage: 'Make sure you have an internet connection.',
          onRetryNow: () {},
        );
      } else {
        AppAlerts.showGeminiErrorDialog(
          context: context,
          errorMessage: 'An unexpected error occurred, please try again.',
          onRetryNow: () {},
        );
      }
    }
  }
}
