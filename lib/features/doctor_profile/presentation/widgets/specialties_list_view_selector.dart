import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/services/overlay_notification_service.dart';

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'custom_day_checkbox_tile.dart';

class SpecialtiesListViewSelector extends StatelessWidget {
  const SpecialtiesListViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DoctorProfileCubit,
      DoctorProfileState,
      Tuple2<List<String>, List<String>>
    >(
      selector: (state) =>
          Tuple2(state.filteredSpecialties, state.selectedSpecialtiesTempList),
      builder: (context, values) => ListView.builder(
        padding: const EdgeInsets.only(bottom: 100),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: values.value1.length,
        itemBuilder: (context, index) {
          final specialties = values.value1[index];
          final isAlreadySelected = values.value2.contains(specialties);
          return CustomCheckboxTile(
            title: specialties,
            isSelected: values.value2.contains(specialties),
            onChanged: (value) {
              final cubit = context.read<DoctorProfileCubit>();

              if (!cubit.canSelectMoreSpecialties && !isAlreadySelected) {
                _showSpecialtyLimitAlert(context);
              } else {
                cubit.toggleMedicalSpecialties(specialties);
              }
            },
          );
        },
      ),
    );
  }

  void _showSpecialtyLimitAlert(BuildContext context) =>
      OverlayNotificationService.show(
        context: context,
        message: AppStrings.specialtyLimitMessage,
        type: SnackBarType.error,
        snackBarBehaviorType: SnackBarBehaviorType.top,
      );
}
