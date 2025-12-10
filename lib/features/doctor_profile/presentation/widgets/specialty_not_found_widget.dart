import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart' show Lottie;
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart' show DoctorProfileCubit;
import 'package:medora/features/shared/presentation/widgets/custom_rich_text.dart' show CustomRichText;

import 'package:medora/generated/assets.dart' show Assets;

class SpecialtyNotFoundWidget extends StatelessWidget {
  const SpecialtyNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: screenHeight * 0.5,
      child: Center(
        child: Column(
          children: [
            _buildLottieAnimation(screenHeight * 0.3),
              Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 5, right: 5),
              child: CustomRichText(
                firstText: AppStrings.searchNoResultsPrefix,
                secondText: context.watch<DoctorProfileCubit>().getLastSearchTerm,
                thirdText:
                AppStrings.searchNoResultsSuffix,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation(double imageHeight) => Lottie.asset(
        Assets.imagesEmptyList,
        fit: BoxFit.cover,
        height: imageHeight,
      );
}
