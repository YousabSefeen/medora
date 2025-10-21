import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/features/doctor_list/presentation/widgets/doctor_list_view.dart' show DoctorListView;

import '../../../../core/constants/common_widgets/sliver_loading _list.dart' show SliverLoadingList;
import '../controller/cubit/doctor_list_cubit.dart';
import '../controller/states/doctor_list_state.dart';

class PopularDoctorsSection extends StatelessWidget {
  const PopularDoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorListCubit, DoctorListState>(
      buildWhen: (previous, current) =>
      previous.doctorList != current.doctorList,
      builder: (context, state) {
        switch (state.doctorListState) {
          case RequestState.initial:
          case RequestState.loading:
            return const SliverLoadingList(height: 150);
          case RequestState.loaded:
            return   DoctorListView(doctorList: state.doctorList);
          case RequestState.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.doctorListError,
                  style: const TextStyle(fontSize: 30, color: Colors.red),
                ),
              ),
            );
        }

      },
    );
  }
}
