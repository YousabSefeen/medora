import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' show Lottie;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/generated/assets.dart' show Assets;

class PaginationFooterWidget extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMore;
  final List<dynamic> doctorsList;
  final String noMoreDataMessage;

  const PaginationFooterWidget({
    super.key,
    required this.isLoadingMore,
    required this.hasMore,
    required this.doctorsList,
    required this.noMoreDataMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return _buildLoadingMoreIndicator();
    }

    if (!hasMore && doctorsList.isNotEmpty && doctorsList.length > 8) {
      return _buildNoMoreDataMessage(context);
    }

    return const SizedBox.shrink();
  }

  Padding _buildNoMoreDataMessage(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 50),
    child: Text(
      noMoreDataMessage,
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.labelFieldStyle.copyWith(fontWeight: FontWeight.w500),
    ),
  );

  Center _buildLoadingMoreIndicator() => Center(
    child: Lottie.asset(
      Assets.imagesIosStyleLoading,
      fit: BoxFit.fill,
      height: 100,
      width: 100,
    ),
  );
}
