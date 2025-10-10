import 'package:flutter/material.dart';
import 'package:medora/core/animations/custom_animation_transition.dart'
    show CustomAnimationTransition;
import 'package:medora/core/enum/animation_type.dart' show AnimationType;

class LabelWithAnimatedValue extends StatelessWidget {
  final String label;
  final TextStyle labelTextStyle;
  final String value;
  final TextStyle valueTextStyle;

  const LabelWithAnimatedValue({
    super.key,
    required this.label,
    required this.value,
    required this.labelTextStyle,
    required this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [_buildLabel(), _buildAnimatedValue()],
    );
  }

  Text _buildLabel() => Text('$label ', style: labelTextStyle);

  CustomAnimationTransition _buildAnimatedValue() => CustomAnimationTransition(
    animationType: AnimationType.slideUp,
    child: Text(value, key: ValueKey(value), style: valueTextStyle),
  );
}
