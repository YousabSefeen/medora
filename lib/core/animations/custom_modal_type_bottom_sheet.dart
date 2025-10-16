import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CustomModalTypeBottomSheet extends WoltModalType {
  CustomModalTypeBottomSheet()
    : super(
        barrierDismissible: true,
        dismissDirection: WoltModalDismissDirection.down,
        transitionDuration: const Duration(milliseconds: 700),
        reverseTransitionDuration: const Duration(milliseconds: 700),
        shapeBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
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
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

    return SlideTransition(position: slideAnimation, child: child);
  }
}
