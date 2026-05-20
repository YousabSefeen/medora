import 'package:flutter/material.dart';

import '../constants/common_widgets/circular_dropdown_icon.dart';

class CustomAnimatedExpansionTile extends StatelessWidget {
  final Widget baseChild;
  final Widget child;
  final bool isExpanded;
  final void Function() onTap;
  final Duration duration;

  const CustomAnimatedExpansionTile({
    super.key,
    required this.baseChild,
    required this.child,
    required this.isExpanded,
    required this.onTap,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 0,
          contentPadding: const EdgeInsets.only(left: 5, right: 1),
          title: baseChild,
          trailing: AnimatedRotation(
            turns: isExpanded ? 1 : 0,
            // Icon rotation animation duration
            duration: const Duration(milliseconds: 1000),
            child: const CircularDropdownIcon(),
          ),

          onTap: onTap,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: child,
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: duration,
          firstCurve: Curves.easeInOut,
          secondCurve: Curves.easeInOut,
        ),
      ],
    );
  }
}
