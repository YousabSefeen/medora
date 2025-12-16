import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' show Lottie;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;
import 'package:medora/generated/assets.dart' show Assets;

class PaginationFooterWidget extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMore;
  final List<DoctorEntity> doctorsList;

  const PaginationFooterWidget({
    super.key,
    required this.isLoadingMore,
    required this.hasMore,
    required this.doctorsList,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return _buildLoadingMoreIndicator();
    }

    if (!hasMore && doctorsList.isNotEmpty) {
      return _buildNoMoreDataMessage(context);
    }

    return const SizedBox.shrink();
  }

  Padding _buildNoMoreDataMessage(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 30),
    child: Text(
      AppStrings.noMoreDoctorsMsg,
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
