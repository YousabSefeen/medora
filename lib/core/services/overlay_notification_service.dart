import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class OverlayNotificationService {
  static _NotificationWidgetState? _currentState;

  static void show({
    required BuildContext context,
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
    SnackBarBehaviorType snackBarBehaviorType = SnackBarBehaviorType.bottom,
  }) {
    // Hide the current notification immediately before showing the new one
    if (_currentState != null) {
      _currentState?.animateAndDismiss();
    }

    final overlayState = Navigator.of(context, rootNavigator: true).overlay;
    if (overlayState == null) return;

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _NotificationWidget(
        message: message,
        type: type,
        duration: duration,
        snackBarBehaviorType: snackBarBehaviorType,
        onStateCreated: (state) => _currentState = state,
        onDismiss: () {
          if (overlayEntry.mounted) {
            overlayEntry.remove();
          }
          if (_currentState == context.findRenderObject()) {
            _currentState = null;
          }
        },
      ),
    );

    overlayState.insert(overlayEntry);
  }

  static Future<void> dismissAll() async {
    await _currentState?.animateAndDismiss();
    _currentState = null;
  }
}

class _NotificationWidget extends StatefulWidget {
  final String message;
  final SnackBarType type;
  final VoidCallback onDismiss;

  final Duration duration;
  final SnackBarBehaviorType? snackBarBehaviorType;
  final Function(_NotificationWidgetState) onStateCreated;

  const _NotificationWidget({
    required this.message,
    required this.type,
    required this.onDismiss,

    required this.duration,
    this.snackBarBehaviorType = SnackBarBehaviorType.top,
    required this.onStateCreated,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _dismissTimer;
  bool _isDismissing = false; //  Preventing repeated execution
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _buildOffsetAnimation();
    _controller.forward();

    widget.onStateCreated(this);

    _dismissTimer = Timer(widget.duration, animateAndDismiss);
  }

  Future<void> animateAndDismiss() async {
    //   Preventing repeated execution
    if (_isDismissing || !mounted) return;
    _isDismissing = true;

    _dismissTimer?.cancel();

    if (mounted && !_controller.isAnimating) {
      await _controller.reverse();

      if (mounted) {
        widget.onDismiss();
      }
    }

    _isDismissing = false;
  }

  void _buildOffsetAnimation() {
    switch (widget.snackBarBehaviorType) {
      case null:
      case SnackBarBehaviorType.top:
        _offsetAnimation = _animate(-1);
        break;
      case SnackBarBehaviorType.bottom:
        _offsetAnimation = _offsetAnimation = _animate(1);
        break;
    }
  }

  Animation<Offset> _animate(double dy) {
    return Tween<Offset>(
      begin: Offset(0, dy), // dy ( Alignment from Top or Bottom)
      end: const Offset(0, 0.05), // It settles at the top
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? topPositioned =
        widget.snackBarBehaviorType == SnackBarBehaviorType.top ? 50 : null;
    double? bottomPositioned =
        widget.snackBarBehaviorType == SnackBarBehaviorType.bottom ? 50 : null;
    return Positioned(
      top: topPositioned,
      bottom: bottomPositioned,
      left: 15,
      right: 15,
      child: Dismissible(
        key: const ValueKey('dismissibleValue'),
        confirmDismiss: (direction) async {
          //Request confirmation before removal
          return true;
        },
        onDismissed: (DismissDirection direction) {
          if (mounted) {
            widget.onDismiss();
          }
        },
        movementDuration: const Duration(milliseconds: 300),
        child: SlideTransition(
          position: _offsetAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _getColor(widget.type),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),

                    child: Center(
                      child: FaIcon(
                        _getIcon(widget.type),
                        color: Colors.white,
                        size: 14.r,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: context.textTheme.overlayNotificationStyle,

                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Color(0xFF4CAF50);

      case SnackBarType.error:
        return const Color(0xFFE53935);

      case SnackBarType.warning:
        return const Color(0xFFFF9800);

      case SnackBarType.info:
        return const Color(0xFF2196F3);
    }
  }

  static FaIconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return FontAwesomeIcons.check;

      case SnackBarType.error:
        return FontAwesomeIcons.xmark;

      case SnackBarType.warning:
        return FontAwesomeIcons.triangleExclamation;

      case SnackBarType.info:
        return FontAwesomeIcons.circleInfo;
    }
  }
}

enum SnackBarType { success, error, warning, info }

enum SnackBarBehaviorType { top, bottom }
