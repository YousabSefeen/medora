import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/entities/doctor_entity.dart';
import '../../../shared/presentation/screens/sliver_pagination_screen_mixin.dart';
import '../../../shared/presentation/widgets/doctor_card.dart';
import '../controller/cubit/doctor_list_cubit.dart';
import '../controller/states/doctor_list_state.dart';

class PopularDoctorsSection extends StatefulWidget {
  final ScrollController scrollController;

  const PopularDoctorsSection({super.key, required this.scrollController});

  @override
  State<PopularDoctorsSection> createState() => _PopularDoctorsSectionState();
}

class _PopularDoctorsSectionState extends State<PopularDoctorsSection>
    with
        SliverPaginationScreenMixin<
          DoctorEntity,
          DoctorListState,
          DoctorListCubit,

          PopularDoctorsSection
        > {
  @override
  void initState() {
    // Connecting the external controller (Important: before super.initState())
    attachScrollController(widget.scrollController);
    super.initState();
  }

  @override
  Widget buildEmptyWidget() => const SliverFillRemaining(
    child: Text('No Doctors Yet', style: TextStyle(color: Colors.red, fontSize: 25)),
  );

  @override
  Widget buildDataCard(DoctorEntity doctor, int index) =>
      DoctorCard(doctor: doctor);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorListCubit, DoctorListState>(
      buildWhen: (previous, current) =>
          previous.isLoadingMore != current.isLoadingMore ||
          previous.requestState != current.requestState,
      builder: (context, state) {
        return buildPaginationBody(context, state);
      },
    );
  }
}
