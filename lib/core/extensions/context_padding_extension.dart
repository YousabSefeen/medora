import 'package:flutter/material.dart';

extension ContextPaddingExtension on BuildContext {
  double get bottomSafePadding {
    final double safeBottom = MediaQuery.paddingOf(this).bottom;
    return safeBottom > 0 ? safeBottom : 16.0;
  }

  EdgeInsets get bottomSafeInsets => EdgeInsets.only(bottom: bottomSafePadding);
}
