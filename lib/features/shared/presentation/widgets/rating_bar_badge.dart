import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/themes/app_colors.dart';

class RatingBarBadge extends StatelessWidget {
  final double? itemPadding;
  final double itemSize;
  final double initialRating;
  final void Function(double) onRatingUpdate;

  const RatingBarBadge({
    super.key,
    this.itemPadding = 5,
    required this.initialRating,
    required this.itemSize,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: itemSize,
      initialRating: initialRating,
      minRating: 1,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: itemPadding!),
      itemBuilder: (context, _) {
        return const FaIcon(
          FontAwesomeIcons.solidStar,
          color: AppColors.brightRed,
        );
      },

      onRatingUpdate: onRatingUpdate,
    );
  }
}
