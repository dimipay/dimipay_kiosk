import 'package:flutter/material.dart';

class DPGestureDetectorWithOpacityInteraction extends StatelessWidget {
  final void Function()? onTap;
  final void Function(TapDownDetails)? onTapDown;
  final void Function()? onTapCancel;
  final Duration duration;
  final Widget child;
  final bool isPressed;

  const DPGestureDetectorWithOpacityInteraction({
    super.key,
    this.onTap,
    this.onTapDown,
    this.onTapCancel,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      child: AnimatedOpacity(
        duration: duration,
        curve: Curves.easeOut,
        opacity: isPressed ? 0.6 : 1,
        child: child,
      ),
    );
  }
}