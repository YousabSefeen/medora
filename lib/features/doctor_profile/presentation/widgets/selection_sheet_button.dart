import 'package:flutter/material.dart';
import 'package:medora/core/constants/common_widgets/circular_dropdown_icon.dart';
import 'package:medora/core/extensions/context_extension.dart';

class SelectionSheetButton extends StatelessWidget {
  final VoidCallback? onInit;
  final VoidCallback? onConfirm;
  final Widget Function(BuildContext context) sheetBuilder;

  const SelectionSheetButton({
    super.key,
    required this.sheetBuilder,
    this.onInit,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return CircularDropdownIcon(onPressed: () => _handlePress(context));
  }

  void _handlePress(BuildContext context) {
    context.ensureKeyboardIsClosed();
    onInit?.call();

    sheetBuilder(context);
  }
}
