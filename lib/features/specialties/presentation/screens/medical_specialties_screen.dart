import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:medora/features/specialties/presentation/widgets/specialty_card_item.dart';

import '../controller/cubit/specialties_cubit.dart';
import '../controller/states/specialties_states.dart';

class MedicalSpecialtiesScreen extends StatefulWidget {
  const MedicalSpecialtiesScreen({super.key});

  @override
  State<MedicalSpecialtiesScreen> createState() =>
      _MedicalSpecialtiesScreenState();
}

class _MedicalSpecialtiesScreenState extends State<MedicalSpecialtiesScreen> {
  @override
  void initState() {
    context.read<SpecialtiesCubit>().fetchAllSpecialties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      appBar: const CustomAppBar(title: AppStrings.medicalSpecialties),
      body: SafeArea(
        child: BlocBuilder<SpecialtiesCubit, SpecialtiesState>(
          buildWhen: (previous, current) =>
              previous.allSpecialtiesStatus != current.allSpecialtiesStatus,
          builder: (context, state) {
            switch (state.allSpecialtiesStatus) {
              case LazyRequestState.lazy:
              case LazyRequestState.loading:
              case LazyRequestState.error:
                return const SizedBox();
              case LazyRequestState.loaded:
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: _buildGridDelegate(),
                  itemCount: state.allSpecialties.length,
                  itemBuilder: (context, index) =>
                      SpecialtyCardItem(specialty: state.allSpecialties[index]),
                );
            }
          },
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount _buildGridDelegate() =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 120,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      );
}
