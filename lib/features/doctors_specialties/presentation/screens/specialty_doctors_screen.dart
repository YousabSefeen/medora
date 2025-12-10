import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/request_state.dart' show RequestState;
import 'package:medora/core/services/server_locator.dart' show serviceLocator;
import 'package:medora/features/shared/presentation/widgets/doctor_list_view.dart'
    show DoctorListView;
import 'package:medora/features/doctors_specialties/presentation/controller/cubit/specialty_doctors_cubit.dart'
    show SpecialtyDoctorsCubit;
import 'package:medora/features/doctors_specialties/presentation/controller/states/specialty_doctors_states.dart'
    show SpecialtyDoctorsStates;
import 'package:medora/features/doctors_specialties/presentation/widgets/empty_specialty_doctors_widget.dart'
    show EmptySpecialtyDoctorsWidget;

import '../../../../core/constants/common_widgets/sliver_loading _list.dart'
    show SliverLoadingList;

class SpecialtyDoctorsScreen extends StatefulWidget {
  final String specialtyName;

  const SpecialtyDoctorsScreen({super.key, required this.specialtyName});

  @override
  State<SpecialtyDoctorsScreen> createState() => _SpecialtyDoctorsScreenState();
}

class _SpecialtyDoctorsScreenState extends State<SpecialtyDoctorsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.softBlue,
        leading: const BackButton(color: Colors.white),
        title: Text(
          widget.specialtyName,
          style: Theme.of(
            context,
          ).appBarTheme.titleTextStyle!.copyWith(color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: BlocProvider(
              create: (context) => serviceLocator<SpecialtyDoctorsCubit>()
                ..getDoctorsBySpecialty(specialtyName: widget.specialtyName),
              child: BlocBuilder<SpecialtyDoctorsCubit, SpecialtyDoctorsStates>(
                builder: (context, state) {
                  switch (state.specialtyDoctorsState) {
                    case RequestState.initial:
                    case RequestState.loading:
                      return const SliverLoadingList(height: 150);
                    case RequestState.loaded:
                      return state.specialtyDoctorsList.isEmpty
                          ? EmptySpecialtyDoctorsWidget(
                              specialtyName: widget.specialtyName,
                            )
                          : DoctorListView(
                              doctorList: state.specialtyDoctorsList,
                            );
                    case RequestState.error:
                      return Center(
                        child: Text(
                          state.specialtyDoctorsError,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
