import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart'
    show TimeSlotCubit;

import '../../../shared/models/doctor_schedule_model.dart';

class SelectDateWidget extends StatelessWidget {
  final DoctorScheduleModel doctorSchedule;

  const SelectDateWidget({super.key, required this.doctorSchedule});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildSectionTitle(context), _buildDateTimeline(context)],
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Text(
      AppStrings.selectDate,
      style: Theme.of(context).textTheme.mediumBlackBold,
      textAlign: TextAlign.start,
    );
  }

  Widget _buildDateTimeline(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 17, right: 8),
      decoration: _dateTimelineDecoration(),
      child: EasyDateTimeLine(
        headerProps: _buildHeaderProps(context),
        initialDate: DateTime.now(),
        activeColor: AppColors.softBlue,
        dayProps: _buildDayProps(context),
        timeLineProps: _buildTimelineProps(),
        onDateChange: (selectedDate) =>
            _handleDateSelection(context, selectedDate),
      ),
    );
  }

  void _handleDateSelection(BuildContext context, DateTime selectedDate) {
    context.read<TimeSlotCubit>().getAvailableDoctorTimeSlots(
      selectedDate: selectedDate,
      doctorSchedule: doctorSchedule,
    );
  }

  BoxDecoration _dateTimelineDecoration() {
    return BoxDecoration(
      color: AppColors.customWhite,
      borderRadius: BorderRadius.circular(10),
    );
  }

  EasyHeaderProps _buildHeaderProps(BuildContext context) {
    final activeTextStyle = Theme.of(context).textTheme.smallWhiteRegular;

    return EasyHeaderProps(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      selectedDateStyle: activeTextStyle.copyWith(
        fontSize: 14.sp,
        color: Colors.black,
      ),
      monthStyle: activeTextStyle.copyWith(
        fontSize: 14.sp,
        color: Colors.black,
      ),
      monthPickerType: MonthPickerType.switcher,
    );
  }

  EasyDayProps _buildDayProps(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final activeTextStyle = textTheme.smallWhiteRegular;
    final inactiveDayStyle = activeTextStyle.copyWith(color: Colors.black);

    return EasyDayProps(
      height: 70,
      width: 40,
      activeDayStyle: _buildActiveDayStyle(activeTextStyle),
      inactiveDayStyle: _buildInactiveDayStyle(inactiveDayStyle),
      todayHighlightStyle: TodayHighlightStyle.withBackground,
      todayStyle: _buildTodayStyle(inactiveDayStyle),
    );
  }

  DayStyle _buildActiveDayStyle(TextStyle activeTextStyle) {
    return DayStyle(
      borderRadius: 10.r,
      dayNumStyle: activeTextStyle,
      dayStrStyle: activeTextStyle,
      monthStrStyle: activeTextStyle,
    );
  }

  DayStyle _buildInactiveDayStyle(TextStyle inactiveDayStyle) {
    return DayStyle(
      borderRadius: 10.r,
      dayNumStyle: inactiveDayStyle,
      dayStrStyle: inactiveDayStyle,
      monthStrStyle: inactiveDayStyle,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }

  DayStyle _buildTodayStyle(TextStyle inactiveDayStyle) {
    return DayStyle(
      borderRadius: 10.r,
      dayNumStyle: inactiveDayStyle,
      dayStrStyle: inactiveDayStyle,
      monthStrStyle: inactiveDayStyle,
    );
  }

  EasyTimeLineProps _buildTimelineProps() {
    return const EasyTimeLineProps(backgroundColor: Colors.white, vPadding: 3);
  }
}
