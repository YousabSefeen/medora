import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:medora/core/constants/app_alerts/app_alerts.dart'
    show AppAlerts;
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart'
    show DoctorProfileCubit;
import 'package:medora/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart'
    show DoctorProfileState;
import 'package:medora/features/doctor_profile/presentation/widgets/custom_confirm_button.dart'
    show CustomConfirmButton;
import 'package:medora/features/doctor_profile/presentation/widgets/specialties_list_view_selector.dart'
    show SpecialtiesListViewSelector;
import 'package:medora/features/doctor_profile/presentation/widgets/specialties_sheet_header.dart'
    show SpecialtiesSheetHeader;
import 'package:medora/features/doctor_profile/presentation/widgets/specialty_not_found_widget.dart'
    show SpecialtyNotFoundWidget;

import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/common_widgets/circular_dropdown_icon.dart';

class SpecialtiesSheetButton extends StatelessWidget {
  const SpecialtiesSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, visible) => IconButton(
        icon: const CircularDropdownIcon(),
        onPressed: () => _handleSpecialtySelectionPress(context, visible),
      ),
    );
  }

  void _handleSpecialtySelectionPress(
    BuildContext context,
    bool isKeyboardVisible,
  ) {
    if (isKeyboardVisible) {
      _dismissKeyboardAndShowSpecialtySheet(context);
    } else {
      _showSpecialtySelectionBottomSheet(context);
    }
  }

  void _dismissKeyboardAndShowSpecialtySheet(BuildContext context) {
    AppRouter.dismissKeyboard();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        _showSpecialtySelectionBottomSheet(context);
      }
    });
  }

  void _showSpecialtySelectionBottomSheet(BuildContext context) {
    _syncTempSpecialtiesFromConfirmed(context);
    _displaySpecialtySelectionSheet(context);
  }

  DoctorProfileCubit _cubit(BuildContext context) =>
      context.read<DoctorProfileCubit>();

  void _syncTempSpecialtiesFromConfirmed(BuildContext context) =>
      _cubit(context).syncTempSpecialtiesFromConfirmed();

  void _confirmAndCloseSpecialtySelection(BuildContext context) {
    _cubit(context).confirmMedicalSpecialtiesSelection();
    AppRouter.popWithKeyboardDismiss(context);
  }

  void _displaySpecialtySelectionSheet(BuildContext context) =>
      AppAlerts.showSpecialitiesBottomSheet(
        context: context,
        trailingNavBarWidget: _buildSearchHeader(context),
        stickyActionBar: _buildConditionalActionBar(),
        body: _buildFilteredSpecialtiesContent(),
      );

  Widget _buildSearchHeader(BuildContext context) => SpecialtiesSheetHeader(
    lastSearchTerm: _cubit(context).getLastSearchTerm,
    onChanged: (searchTerm) => _cubit(context).searchSpecialty(searchTerm),
  );

  KeyboardVisibilityBuilder
  _buildConditionalActionBar() => KeyboardVisibilityBuilder(
    builder: (context, isKeyboardVisible) => isKeyboardVisible
        ? const SizedBox.shrink()
        : BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
            selector: (state) => state.filteredSpecialties,
            builder: (context, filteredSpecialties) =>
                filteredSpecialties.isEmpty
                ? const SizedBox()
                : _buildConfirmationButton(context),
          ),
  );

  CustomConfirmButton _buildConfirmationButton(BuildContext context) =>
      CustomConfirmButton(
        onPressed: () => _confirmAndCloseSpecialtySelection(context),
      );

  BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>
  _buildFilteredSpecialtiesContent() =>
      BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
        selector: (state) => state.filteredSpecialties,
        builder: (context, filteredSpecialties) => filteredSpecialties.isEmpty
            ? const SpecialtyNotFoundWidget()
            : const SpecialtiesListViewSelector(),
      );
}
