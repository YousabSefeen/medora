import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:medora/core/constants/app_borders/app_borders.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/common_widgets/field_error_text.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/gender_type.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/form_title.dart';
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart';
import 'package:medora/features/patient/presentation/controllers/state/patient_state.dart';

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
          dz.Tuple2<GenderType, AutovalidateMode>
        >(
          selector: (state) => dz.Tuple2(state.genderType, state.validateMode),
          builder: (context, state) {
            final gender = state.value1;
            final isError =
                gender == GenderType.init &&
                state.value2 == AutovalidateMode.always;

            return _GenderDropdownField(
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

class _GenderDropdownField extends StatefulWidget {
  final GenderType selectedGender;
  final bool hasError;
  final Function(GenderType) onChanged;

  const _GenderDropdownField({
    required this.selectedGender,
    required this.hasError,
    required this.onChanged,
  });

  @override
  State<_GenderDropdownField> createState() => _GenderDropdownFieldState();
}

class _GenderDropdownFieldState extends State<_GenderDropdownField> {
  late final SuggestionsController<GenderType> _suggestionsController;

  static const List<GenderType> _genderOptions = [
    GenderType.male,
    GenderType.female,
  ];

  @override
  void initState() {
    super.initState();
    _suggestionsController = SuggestionsController<GenderType>();
  }

  @override
  void dispose() {
    _suggestionsController.dispose();
    super.dispose();
  }

  String _getDisplayText(GenderType type) => type == GenderType.init
      ? AppStrings.genderHint
      : (type == GenderType.male ? AppStrings.male : AppStrings.female);

  InputBorder _buildBorder() => !widget.hasError
      ? AppBorders.inputEnabledBorder
      : AppBorders.inputErrorBorder;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TypeAheadField<GenderType>(
          animationDuration: AppDurations.milliseconds_500,
          suggestionsController: _suggestionsController,
          suggestionsCallback: (_) => _genderOptions,
          builder: (context, controller, focusNode) {
            controller.text = _getDisplayText(widget.selectedGender);

            return TextField(
              controller: controller,
              focusNode: focusNode,
              readOnly: true,
              style: widget.selectedGender == GenderType.init
                  ? textTheme.hintFieldStyle
                  : textTheme.styleInputField,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                border: _buildBorder(),
                enabledBorder: _buildBorder(),
                focusedBorder: _buildBorder(),
                suffixIcon: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                  size: 23.sp,
                  color: Colors.black54,
                ),
              ),
            );
          },
          itemSeparatorBuilder: (context, i) =>
              const Divider(color: Colors.white60, thickness: 0.5, height: 10),
          itemBuilder: (context, genderItem) {
            final isSelected = widget.selectedGender == genderItem;

            return Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    genderItem == GenderType.male
                        ? AppStrings.male
                        : AppStrings.female,
                    style: textTheme.styleInputField.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  if (isSelected) _buildSelectedCheckIcon(),
                ],
              ),
            );
          },
          onSelected: (genderItem) {
            widget.onChanged(genderItem);
            _suggestionsController.close();
          },
          decorationBuilder: (context, child) => Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: context.screenWidth * 0.5,
              child: Material(
                elevation: 4,
                borderRadius: AppBorders.defaultBorderRadius,
                color: Colors.black87,
                child: ClipRRect(
                  borderRadius: AppBorders.defaultBorderRadius,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.hasError,
          child: const FieldErrorText(
            errorText: AppStrings.requiredGenderField,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedCheckIcon() => CircleAvatar(
    radius: 10.r,
    backgroundColor: Colors.green,
    child: Icon(Icons.done_rounded, color: Colors.white, size: 15.r),
  );
}
