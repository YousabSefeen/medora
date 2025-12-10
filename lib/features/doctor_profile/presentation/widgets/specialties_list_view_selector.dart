import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart'
    show KeyboardVisibilityBuilder;
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'custom_day_checkbox_tile.dart';

/// Bottom sheet that displays a scrollable ListView for selecting working days
///
/// Contains:
/// - ListView.builder with checkboxes for each day of the week
/// - Confirm button to save selections
/// - Managed state through BLoC for temporary day selections
class SpecialtiesListViewSelector extends StatelessWidget {
  const SpecialtiesListViewSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final double boxHeight = MediaQuery.sizeOf(context).height * 0.75;
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: boxHeight,
          maxHeight: isKeyboardVisible ? double.maxFinite : boxHeight,
        ),
        child:
            BlocSelector<
              DoctorProfileCubit,
              DoctorProfileState,
              Tuple2<List<String>, List<String>>
            >(
              selector: (state) => Tuple2(
                state.filteredSpecialties,
                state.selectedSpecialtiesTempList,
              ),
              builder: (context, values) => Scrollbar(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: values.value1.length,
                  itemBuilder: (context, index) {
                    final specialties = values.value1[index];
                    final isAlreadySelected = values.value2.contains(
                      specialties,
                    );
                    return CustomCheckboxTile(
                      title: specialties,
                      isSelected: values.value2.contains(specialties),
                      onChanged: (value) {
                        final cubit = context.read<DoctorProfileCubit>();

                        if (!cubit.canSelectMoreSpecialties &&
                            !isAlreadySelected) {
                          _showSpecialtyLimitAlert(context);
                        } else {
                          cubit.toggleMedicalSpecialties(specialties);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
      ),
    );
  }

  _buildConstrainedBox(
    BuildContext context,
    bool isKeyboardVisible,
    Widget child,
  ) {
    ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: isKeyboardVisible
            ? double.infinity
            : MediaQuery.sizeOf(context).height * 0.75,
        maxHeight: isKeyboardVisible
            ? double.infinity
            : MediaQuery.sizeOf(context).height * 0.75,
      ),
      child: child,
    );
  }

  void _showSpecialtyLimitAlert(BuildContext context) =>
      AppAlerts.showTopSnackBarAlert(
        context: context,
        msg: AppStrings.specialtyLimitMessage,
        backgroundColor: AppColors.red,
      );
}
