import 'package:flutter/material.dart';

class ScrollControllerProvider extends InheritedWidget {
  final ScrollController scrollController;

  const ScrollControllerProvider({
    super.key,
    required this.scrollController,
    required super.child,
  });

  static ScrollController of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ScrollControllerProvider>();
    assert(provider != null, 'No ScrollControllerProvider found in context');
    return provider!.scrollController;
  }

  @override
  bool updateShouldNotify(ScrollControllerProvider oldWidget) {
    return scrollController != oldWidget.scrollController;
  }
}
