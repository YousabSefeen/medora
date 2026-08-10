import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:medora/core/animations/custom_modal_type_bottom_sheet.dart';

import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart';
import 'package:medora/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/custom_confirm_button.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/selection_sheet_button.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/specialties_list_view_selector.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/specialties_sheet_header.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/specialty_not_found_widget.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class SpecialtiesSheetButton extends StatelessWidget {
  const SpecialtiesSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorProfileCubit>();

    return SelectionSheetButton(
      onInit: () => cubit.syncTempSpecialtiesFromConfirmed(),
      sheetBuilder: (sheetContext) {
        WoltModalSheet.show(
          context: context,
          modalTypeBuilder: (_) => CustomModalTypeBottomSheet(),
          barrierDismissible: true,
          pageListBuilder: (modalSheetContext) => [
            WoltModalSheetPage(
              hasSabGradient: false,
              topBar: const SizedBox(),

              stickyActionBar: BlocProvider.value(
                value: cubit,
                child:
                    BlocSelector<
                      DoctorProfileCubit,
                      DoctorProfileState,
                      List<String>
                    >(
                      selector: (state) => state.filteredSpecialties,
                      builder: (context, filteredSpecialties) =>
                          filteredSpecialties.isEmpty
                          ? const SizedBox.shrink()
                          : CustomConfirmButton(
                              onPressed: () {
                                cubit.confirmMedicalSpecialtiesSelection();
                                sheetContext.pop();
                              },
                            ),
                    ),
              ),
              isTopBarLayerAlwaysVisible: true,
              trailingNavBarWidget: SpecialtiesSheetHeader(
                lastSearchTerm: cubit.getLastSearchTerm,
                onChanged: cubit.searchSpecialty,
              ),
              child: BlocProvider.value(
                value: cubit,
                child:
                    BlocSelector<
                      DoctorProfileCubit,
                      DoctorProfileState,
                      List<String>
                    >(
                      selector: (state) => state.filteredSpecialties,
                      builder: (context, filteredSpecialties) =>
                          filteredSpecialties.isEmpty
                          ? const SpecialtyNotFoundWidget()
                          : const SpecialtiesListViewSelector(),
                    ),
              ),
            ),
          ],
          onModalDismissedWithBarrierTap: () => context.pop(),
        );

        return const SizedBox.shrink();
      },
    );
  }
}
