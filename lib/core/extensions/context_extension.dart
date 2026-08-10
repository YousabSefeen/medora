import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Future<void> ensureKeyboardIsClosed() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!mounted) return;

    while (mounted && View.of(this).viewInsets.bottom > 0) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }
}
