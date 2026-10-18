import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/domain/entities/doctor_entity.dart';
import '../../../shared/presentation/screens/sliver_pagination_screen_mixin.dart';
import '../../../shared/presentation/widgets/doctor_card.dart';
import '../controller/cubit/specialty_doctors_cubit.dart';
import '../controller/states/specialty_doctors_state.dart';
import 'empty_specialty_doctors_view.dart';

class SpecialtyDoctorsList extends StatefulWidget {
  final ScrollController scrollController;

  const SpecialtyDoctorsList({super.key, required this.scrollController});

  @override
  State<SpecialtyDoctorsList> createState() => _SpecialtyDoctorsListState();
}

class _SpecialtyDoctorsListState extends State<SpecialtyDoctorsList>
    with
        SliverPaginationScreenMixin<
          DoctorEntity,
          SpecialtyDoctorsState,
          SpecialtyDoctorsCubit,
          SpecialtyDoctorsList
        > {
  @override
  void initState() {
    attachScrollController(widget.scrollController);
    super.initState();
  }

  @override
  Widget buildEmptyWidget() => EmptySpecialtyDoctorsView(
    specialtyName: context.read<SpecialtyDoctorsCubit>().state.specialtyName,
  );

  @override
  Widget buildDataCard(DoctorEntity doctor, int index) =>
      DoctorCard(doctor: doctor);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtyDoctorsCubit, SpecialtyDoctorsState>(
      buildWhen: (previous, current) =>
          previous.isLoadingMore != current.isLoadingMore ||
          previous.requestState != current.requestState,
      builder: (context, state) => buildPaginationBody(context, state),
    );
  }
}
