// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
// import 'package:flutter_task/core/constants/themes/app_colors.dart';
// import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
//
// import 'custom_field_container.dart';
// import 'days_sheet_button.dart';
//
// class SelectedDaysContainer extends StatelessWidget {
//   final bool isWorkingDaysEmpty;
//   final List<String> confirmedDays;
//   final FormFieldState<List<String>> field;
//
//   const SelectedDaysContainer({
//     super.key,
//     required this.isWorkingDaysEmpty,
//     required this.confirmedDays,
//     required this.field,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomFieldContainer(
//       field: field,
//       child: Row(
//         crossAxisAlignment: isWorkingDaysEmpty
//             ? CrossAxisAlignment.center
//             : CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: isWorkingDaysEmpty
//                 ? _buildHintText(context)
//                 : _buildDaysWrap(context),
//           ),
//           const DaysSheetButton(),
//         ],
//       ),
//     );
//   }
//
//   /// Build  the hint text when no working days are selected.
//   Widget _buildHintText(BuildContext context) => Align(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           AppStrings.workingDaysHint,
//           style: Theme.of(context).textTheme.hintFieldStyle,
//         ),
//       );
//
//   /// Build  a Wrap of confirmed selected days.
//   Widget _buildDaysWrap(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       runSpacing: 8,
//       children:
//           confirmedDays.map((day) => _buildDayChip(context, day)).toList(),
//     );
//   }
//
//   /// Build  an individual chip for a selected day.
//   Widget _buildDayChip(BuildContext context, String day) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: AppColors.green,
//           borderRadius: BorderRadius.circular(50.r),
//         ),
//         child: Text(
//           day,
//           style: Theme.of(context).textTheme.mediumBlack.copyWith(
//                 color: Colors.white,
//                 fontSize: 14.sp,
//               ),
//         ),
//       );
// }
