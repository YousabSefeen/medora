import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';

import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/features/doctor_profile/presentation/controller/cubit/doctor_profile_cubit.dart'
    show DoctorProfileCubit;
import 'package:time_range/time_range.dart';

import '../../../../core/constants/themes/app_colors.dart';

class TimeRangePicker extends StatefulWidget {
  final bool isWorkHoursExpanded;

  const TimeRangePicker({super.key, required this.isWorkHoursExpanded});

  @override
  State<TimeRangePicker> createState() => _TimeRangePickerState();
}

class _TimeRangePickerState extends State<TimeRangePicker> {
  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 8, minute: 00),
    const TimeOfDay(hour: 22, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TimeRange(
        fromTitle: widget.isWorkHoursExpanded
            ? Text(AppStrings.from.toCapitalizeFirstLetter(), style: _getLabelFieldStyle(textTheme))
            : null,
        toTitle: widget.isWorkHoursExpanded
            ? Text(AppStrings.to.toCapitalizeFirstLetter(), style: _getLabelFieldStyle(textTheme))
            : null,
        titlePadding: 3,
        textStyle: Theme.of(context).textTheme.numbersStyle,
        activeTextStyle: _getActiveTextStyle(textTheme),
        activeBackgroundColor: AppColors.green,
        activeBorderColor: Colors.black12,
        borderColor: Colors.black26,
        firstTime: const TimeOfDay(hour: 8, minute: 00),
        lastTime: const TimeOfDay(hour: 20, minute: 00),
        initialRange: _timeRange,
        timeStep: 60,
        timeBlock: 60,
        onRangeCompleted: (range) {
          setState(() => _timeRange = range);
          context.read<DoctorProfileCubit>().updateWorkHoursSelected(
            _timeRange != null,
            _timeRange?.start.format(context),
            _timeRange?.end.format(context),
          );
        },
        onFirstTimeSelected: (startHour) {},
      ),
    );
  }

  TextStyle _getActiveTextStyle(TextTheme textTheme) => textTheme.numbersStyle
      .copyWith(color: Colors.white, fontWeight: FontWeight.w600);

  TextStyle _getLabelFieldStyle(TextTheme textTheme) => textTheme.mediumBlack
      .copyWith(fontSize: 13.sp, color: AppColors.black87,fontWeight: FontWeight.w700);
}
