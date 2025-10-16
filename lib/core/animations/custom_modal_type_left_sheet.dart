import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CustomModalTypeLeftSheet extends WoltModalType {
  CustomModalTypeLeftSheet()
    : super(
        barrierDismissible: false,
        dismissDirection: WoltModalDismissDirection.none,
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 600),
      );

  @override
  String routeLabel(BuildContext context) {
    return 'Custom Modal';
  }

  @override
  BoxConstraints layoutModal(Size availableSize) {
    return BoxConstraints(
      maxWidth: availableSize.width,
      maxHeight: availableSize.height,
    );
  }

  @override
  Offset positionModal(
    Size availableSize,
    Size modalContentSize,
    TextDirection textDirection,
  ) {
    return Offset(
      (availableSize.width - modalContentSize.width),
      (availableSize.height - modalContentSize.height),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    return SlideTransition(position: slideAnimation, child: child);
  }
}
