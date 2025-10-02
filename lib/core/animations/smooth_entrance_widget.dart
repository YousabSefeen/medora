import 'package:flutter/material.dart';

class SmoothEntranceWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SmoothEntranceWidget({
    super.key,
    required this.child,
    required this.duration,
  });

  @override
  State<SmoothEntranceWidget> createState() => _SmoothEntranceWidgetState();
}

class _SmoothEntranceWidgetState extends State<SmoothEntranceWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    Future.microtask(() => _controller.forward());

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
