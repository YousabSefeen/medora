import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../generated/assets.dart';

class ContentUnavailableWidget extends StatelessWidget {
  final bool? isExpandedHeight;
  final String description;

  const ContentUnavailableWidget({
    super.key,
    this.isExpandedHeight = true,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final height = isExpandedHeight!
        ? deviceSize.height * 0.5
        : deviceSize.height * 0.25;
    final width = deviceSize.width * 0.8;
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            _buildLottieAnimation(),
            _buildMessageText(context, description),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation() => Expanded(
    child: Container(
      child: Lottie.asset(Assets.imagesEmptyList, fit: BoxFit.cover),
    ),
  );

  Widget _buildMessageText(BuildContext context, String description) =>
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
          child: Text(
            description,
            style: Theme.of(context).textTheme.smallOrangeMedium,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
