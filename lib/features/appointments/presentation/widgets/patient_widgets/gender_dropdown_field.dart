import 'package:animated_drop_down_form_field/animated_drop_down_form_field.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_borders/app_borders.dart'
    show AppBorders;
import 'package:medora/core/constants/app_duration/app_duration.dart'
    show AppDurations;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/field_error_text.dart'
    show FieldErrorText;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/patient_cubit.dart'
    show PatientCubit;
import 'package:medora/features/appointments/presentation/controller/cubit/patient_state.dart'
    show PatientState;
import 'package:medora/features/doctor_profile/presentation/widgets/form_title.dart'
    show FormTitle;

class GenderDropdownField extends StatelessWidget {
  const GenderDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle(label: AppStrings.genderLabel),
        BlocSelector<
          PatientCubit,
          PatientState,
          Tuple2<GenderType, AutovalidateMode>
        >(
          selector: (state) => Tuple2(state.genderType, state.validateMode),
          builder: (context, state) {
            final gender = state.value1;
            final isError =
                gender == GenderType.init &&
                state.value2 == AutovalidateMode.always;

            return _GenderDropdownView(
              selectedGender: gender,
              hasError: isError,
              onChanged: (index) => context
                  .read<PatientCubit>()
                  .onChangeSelectedGenderIndex(index),
            );
          },
        ),
      ],
    );
  }
}

class _GenderDropdownView extends StatelessWidget {
  final GenderType selectedGender;
  final bool hasError;
  final Function(int) onChanged;

  const _GenderDropdownView({
    required this.selectedGender,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDropDownFormField(
          items: _buildGenderItems(textTheme),
          listScrollPhysics: const BouncingScrollPhysics(),
          placeHolder: Text(
            _getDisplayText(selectedGender),
            style: _getTextStyle(selectedGender, textTheme),
          ),
          buttonDecoration: _buildButtonDecoration(),
          listBackgroundDecoration: _buildListDecoration(),
          separatorWigdet: const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Divider(color: Colors.white38, thickness: 2),
          ),
          buttonPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 10,
          ),
          actionWidget: Icon(Icons.arrow_drop_down_circle_sharp, size: 23.sp),
          listPadding: const EdgeInsets.all(15),
          listMargin: EdgeInsets.only(left: context.screenWidth * 0.5),
          selectedItemIcon: _buildSelectedIcon(),
          dropDownAnimationParameters: _buildAnimationParameters(),
          onChangeSelectedIndex: onChanged,
        ),

        Visibility(
          visible: hasError,
          child: const FieldErrorText(
            errorText: AppStrings.requiredGenderField,
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildButtonDecoration() => BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: AppBorders.defaultBorderRadius,
    border: hasError ? AppBorders.errorBorder : AppBorders.subtleBorder,
  );

  BoxDecoration _buildListDecoration() => BoxDecoration(
    borderRadius: AppBorders.defaultBorderRadius,
    color: Colors.black87,
    boxShadow: const [BoxShadow(color: Colors.white12, blurRadius: 4)],
  );

  String _getDisplayText(GenderType type) => type == GenderType.init
      ? AppStrings.genderHint
      : (type == GenderType.male ? AppStrings.male : AppStrings.female);

  TextStyle _getTextStyle(GenderType type, TextTheme theme) =>
      type == GenderType.init ? theme.hintFieldStyle : theme.styleInputField;

  List<Widget> _buildGenderItems(TextTheme theme) {
    final style = theme.styleInputField.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return [
      Text(AppStrings.male, style: style),
      Text(AppStrings.female, style: style),
    ];
  }

  Widget _buildSelectedIcon() => CircleAvatar(
    radius: 10.r,
    backgroundColor: Colors.green,
    child: Icon(Icons.done_rounded, color: Colors.white, size: 15.r),
  );

  SizingDropDownAnimationParameters _buildAnimationParameters() =>
      const SizingDropDownAnimationParameters(
        duration: AppDurations.milliseconds_600,
        curve: Curves.ease,
        reversDuration: AppDurations.milliseconds_600,
        reverseCurve: Curves.ease,
      );
}
