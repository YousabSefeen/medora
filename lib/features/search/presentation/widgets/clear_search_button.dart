import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocSelector;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/enum/animation_type.dart' show AnimationType;
import 'package:medora/features/search/presentation/controller/cubit/search_cubit.dart'
    show SearchCubit;
import 'package:medora/features/search/presentation/controller/states/search_states.dart'
    show SearchStates;

class ClearSearchButton extends StatelessWidget {
  final void Function() onPressed;

  const ClearSearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SearchCubit, SearchStates, String?>(
      selector: (state) => state.doctorName,
      builder: (context, doctorName) {
        final isDoctorNameEmpty = doctorName == null || doctorName == '';

        return CustomAnimationTransition(
          animationType: AnimationType.fade,
          child: Visibility(
            key: ValueKey(isDoctorNameEmpty),
            visible: !isDoctorNameEmpty,
            child: Padding(
              padding: const EdgeInsets.only(right: 3),

              child: Container(
                height: 23,
                width: 23,
                decoration: _buildBoxDecoration(),

                child: Center(
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    splashRadius: 30,
                    onPressed: onPressed,
                    icon: _buildIcon(),
                    style: _buildButtonStyle(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildBoxDecoration() =>
      const BoxDecoration(shape: BoxShape.circle, color: AppColors.red);

  Icon _buildIcon() =>
      Icon(FontAwesomeIcons.xmark, size: 13.sp, color: Colors.white);

  ButtonStyle _buildButtonStyle() =>
      const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.grey));
}
