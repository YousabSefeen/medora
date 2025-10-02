import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../../core/animations/custom_animated_expansion_tile.dart';
import '../../../../core/animations/animated_fade_transition.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'selected_work_hours_display.dart';
import 'time_range_picker.dart';

class WorkHoursSelector extends StatelessWidget {
  const WorkHoursSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState,
        dartz.Tuple2<bool, Map<String, String>>>(
      selector: (state) =>
          dartz.Tuple2(state.isWorkHoursExpanded, state.workHoursSelected),
      builder: (context, values) => CustomAnimatedExpansionTile(
        baseChild: buildBaseChild(context, values.value2),
        isExpanded: values.value1,
        onTap: () => buildToggleWorkHoursExpanded(context),
        child: _buildTimeRangePicker( values.value1),
      ),
    );
  }

  Widget buildBaseChild(
      BuildContext context, Map<String, String> workHoursSelected) {
    if (workHoursSelected.isEmpty) {
      return AnimatedFadeTransition(
        child: Text(AppStrings.workHoursHint,
            style: Theme.of(context)
                .textTheme
                .hintFieldStyle
                .copyWith(fontWeight: FontWeight.w400)),
      );
    } else {
      return SelectedWorkHoursDisplay(workHoursSelected: workHoursSelected);
    }
  }

  void buildToggleWorkHoursExpanded(BuildContext context) =>
      context.read<DoctorProfileCubit>().toggleWorkHoursExpanded();

  Widget _buildTimeRangePicker(bool isWorkHoursExpanded) =>   TimeRangePicker(isWorkHoursExpanded: isWorkHoursExpanded );
}
