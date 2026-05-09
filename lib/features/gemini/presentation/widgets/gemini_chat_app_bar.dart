import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart'
    show AppTextStyles;
import 'package:medora/core/enum/lazy_request_state.dart' show LazyRequestState;
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:medora/features/gemini/presentation/controllers/cubit/google_gemini_cubit.dart' show GoogleGeminiCubit;

import 'package:medora/features/gemini/presentation/controllers/states/gemini_chat_state.dart'
    show GeminiChatState;

class GeminiChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeminiChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1.5,
      backgroundColor: AppColors.customWhite,
      title: Text(AppStrings.chatAppBarTitle, style: context.textTheme.buttonStyle.copyWith(
        color: Colors.black
      )),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: BlocConsumer<GoogleGeminiCubit, GeminiChatState>(
          listener: (BuildContext context, GeminiChatState state) =>
              _handleErrorState(state, context),
          builder: (BuildContext context, GeminiChatState state) =>
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

  void _handleErrorState(GeminiChatState state, BuildContext context) {
    if (state.requestState == LazyRequestState.error) {
      print('_ChatViewState.build55555555555555555555555555555555555555555');
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
