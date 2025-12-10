import 'package:animated_drop_down_form_field/animated_drop_down_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/gender_type.dart' show GenderType;
import 'package:medora/features/appointments/presentation/controller/cubit/appointment_cubit.dart'
    show AppointmentCubit;
import 'package:medora/features/appointments/presentation/controller/states/appointment_state.dart'
    show AppointmentState;

import '../../../../doctor_profile/presentation/widgets/form_title.dart';

class GenderDropdownField extends StatelessWidget {
  final AnimatedDropDownFormFieldController controller;

  const GenderDropdownField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle(label: 'Gender'),
        BlocSelector<AppointmentCubit, AppointmentState, GenderType>(
          selector: (state) => state.genderType,
          builder: (context, selectedGenderIndex) => AnimatedDropDownFormField(
            items: _buildGenderItems(textTheme),
            listScrollPhysics: const BouncingScrollPhysics(),
            placeHolder: Text(
              _getDisplayText(selectedGenderIndex),
              style: _getTextStyle(selectedGenderIndex, textTheme),
            ),
            separatorWigdet: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(color: Colors.white38, thickness: 2),
            ),
            buttonPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            actionWidget: Icon(
              Icons.arrow_drop_down_circle_sharp,
              color: Colors.black,
              size: 23.sp,
            ),
            buttonDecoration: _buildButtonDecoration(),
            listBackgroundDecoration: _buildListDecoration(),
            listPadding: const EdgeInsets.only(
              left: 10,
              right: 15,
              top: 15,
              bottom: 15,
            ),
            listMargin: EdgeInsets.only(
              left: MediaQuery.sizeOf(context).width * 0.5,
            ),
            selectedItemIcon: _buildSelectedIcon(),
            dropDownAnimationParameters: _buildAnimationParameters(),
            controller: controller,
            errorWidget: Text(
              'Please select your gender',
              style: textTheme.styleInputFieldError,
            ),
            errorBorder: Border.all(color: Colors.red, width: 1.7),
            onChangeSelectedIndex: (int index) {
              context.read<AppointmentCubit>().onChangeSelectedGenderIndex(
                index,
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDisplayText(GenderType genderType) {
    String displayText = '';
    switch (genderType) {
      case GenderType.init:
        return 'Select Gender';
      case GenderType.male:
        return 'Male';
      case GenderType.female:
        return 'Female';
    }
  }

  List<Widget> _buildGenderItems(TextTheme textTheme) {
    final customTextStyle = textTheme.styleInputField.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
    return [
      Text('Male', style: customTextStyle),
      Text('Female', style: customTextStyle),
    ];
  }

  BoxDecoration _buildButtonDecoration() => BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(8.r),
    border: Border.all(color: Colors.black12, width: 1.2),
  );

  BoxDecoration _buildListDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.black87,
    boxShadow: const [BoxShadow(color: Colors.white12, blurRadius: 4)],
  );

  Widget _buildSelectedIcon() => CircleAvatar(
    radius: 10.r,
    backgroundColor: Colors.green,
    child: Icon(Icons.done_rounded, color: Colors.white, size: 15.r),
  );

  SizingDropDownAnimationParameters _buildAnimationParameters() =>
      const SizingDropDownAnimationParameters(
        duration: Duration(milliseconds: 600),
        reversDuration: Duration(milliseconds: 300),
        curve: Curves.ease,
        reverseCurve: Curves.ease,
      );

  TextStyle _getTextStyle(GenderType genderType, TextTheme textTheme) {
    return genderType == GenderType.init
        ? textTheme.hintFieldStyle
        : textTheme.styleInputField;
  }

  // void _handleSelectionChange(BuildContext context, int? index) {
  //   context.read<AppointmentCubit>().onChangeSelectedGenderIndex(index!);
  // }
}
