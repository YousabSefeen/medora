import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MyCustomModalTypeDialog extends WoltModalType {
  final double? defaultMaxWidth;

  MyCustomModalTypeDialog({this.defaultMaxWidth = 0.8})
    : super(
        showDragHandle: false,
        transitionDuration: const Duration(milliseconds: 1500),
        reverseTransitionDuration: const Duration(milliseconds: 400),
      );

  @override
  String routeLabel(BuildContext context) {
    return 'Custom Modal';
  }

  @override
  BoxConstraints layoutModal(Size availableSize) {
    return BoxConstraints(
      minWidth: availableSize.width * 0.6,
      maxWidth: defaultMaxWidth == null
          ? availableSize.width * 0.8
          : availableSize.width * defaultMaxWidth!,
      minHeight: availableSize.height * 0.4,
      maxHeight: availableSize.height * 0.8,
    );
  }

  @override
  Offset positionModal(
    Size availableSize,
    Size modalContentSize,
    TextDirection textDirection,
  ) {
    // تحديد موقع الـ modal على الشاشة
    return Offset(
      (availableSize.width - modalContentSize.width) / 2,
      (availableSize.height - modalContentSize.height) / 2,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // تحديد تأثيرات الانتقال المخصصة
    return FadeTransition(opacity: animation, child: child);
  }
}
