import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:medora/features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart'
    show DoctorListCubit;
import 'package:medora/features/doctor_list/presentation/controller/states/doctor_list_state.dart'
    show DoctorListState;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart'
    show DoctorEntity;
import 'package:medora/features/shared/presentation/screens/sliver_pagination_screen_mixin.dart'
    show SliverPaginationScreenMixin;
import 'package:medora/features/shared/presentation/widgets/doctor_card.dart'
    show DoctorCard;

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
  Widget buildDataCard(DoctorEntity doctor, int index) {
    return DoctorCard(doctor: doctor);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorListCubit, DoctorListState>(
      builder: (context, state) {
        return buildPaginationBody(context, state);
      },
    );
  }
}
