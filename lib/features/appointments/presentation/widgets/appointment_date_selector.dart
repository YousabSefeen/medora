import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart'
    show TimeSlotCubit;

import '../../../shared/models/doctor_schedule_model.dart';

class AppointmentDateSelector extends StatelessWidget {
  final DoctorScheduleModel doctorSchedule;

  const AppointmentDateSelector({super.key, required this.doctorSchedule});

  @override
  Widget build(BuildContext context) {
    final activeTextStyle = context.textTheme.robotoMediumStyle;

    final inactiveTextStyle = activeTextStyle.copyWith(
      color: Colors.grey.shade600,
    );

    final headerTextStyle = Theme.of(context).textTheme.dateTimeBlackStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.chooseDate,
          style: Theme.of(context).textTheme.mediumBlackBold,
        ),

        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 17),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: EasyDateTimeLine(
            initialDate: DateTime.now(),
            activeColor: AppColors.softBlue,

            // Header settings (Month Picker)
            headerProps: EasyHeaderProps(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              selectedDateStyle: headerTextStyle,
              monthStyle: headerTextStyle,
              monthPickerType: MonthPickerType.switcher,
            ),

            // Day Dimensions and Style Settings
            dayProps: EasyDayProps(
              height: 70,
              width: 40,
              todayHighlightStyle: TodayHighlightStyle.withBackground,

              activeDayStyle: DayStyle(
                borderRadius: 10.r,
                dayNumStyle: activeTextStyle,
                dayStrStyle: activeTextStyle,
                monthStrStyle: activeTextStyle,
              ),

              inactiveDayStyle: DayStyle(
                borderRadius: 10.r,
                dayNumStyle: inactiveTextStyle,
                dayStrStyle: inactiveTextStyle,
                monthStrStyle: inactiveTextStyle,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),

              todayStyle: DayStyle(
                borderRadius: 10.r,
                dayNumStyle: inactiveTextStyle,
                dayStrStyle: inactiveTextStyle,
                monthStrStyle: inactiveTextStyle,
              ),
            ),

            timeLineProps: const EasyTimeLineProps(
              backgroundColor:Colors.white,
              vPadding: 3,
            ),

            // Date change occurred
            onDateChange: (selectedDate) {
              context.read<TimeSlotCubit>().getAvailableDoctorTimeSlots(
                selectedDate: selectedDate,
                doctorSchedule: doctorSchedule,
              );
            },
          ),
        ),
      ],
    );
  }
}
