import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/enum/lazy_request_state.dart';
import 'package:medora/features/specialties/presentation/widgets/specialty_card_item.dart';

import '../controller/cubit/specialties_cubit.dart';
import '../controller/states/specialties_states.dart';

class TopSpecialtiesList extends StatelessWidget {
  const TopSpecialtiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtiesCubit, SpecialtiesState>(
      buildWhen: (previous, current) =>
          previous.topSpecialtiesStatus != current.topSpecialtiesStatus,

      builder: (context, state) {
        switch (state.topSpecialtiesStatus) {
          case LazyRequestState.lazy:
          case LazyRequestState.loading:
          case LazyRequestState.error:
            return const SliverToBoxAdapter();
          case LazyRequestState.loaded:
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 95.h,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.topSpecialties.length,
                  itemBuilder: (context, index) =>
                      SpecialtyCardItem(specialty: state.topSpecialties[index]),
                ),
              ),
            );
        }
      },
    );
  }
}
