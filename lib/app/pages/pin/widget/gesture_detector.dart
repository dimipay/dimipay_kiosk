import 'package:flutter/material.dart';

class DPGestureDetectorWithOpacityInteraction extends StatefulWidget {
  final void Function()? onTap;
  final Duration duration;
  final Widget child;
  const DPGestureDetectorWithOpacityInteraction({super.key, this.onTap, required this.child, this.duration = const Duration(milliseconds: 100)});

  @override
  State<DPGestureDetectorWithOpacityInteraction> createState() => _DPGestureDetectorWithOpacityInteractionState();
}

class _DPGestureDetectorWithOpacityInteractionState extends State<DPGestureDetectorWithOpacityInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapCancel: pressUp,
      child: Listener(
        onPointerDown: (_) => pressDown(),
        onPointerUp: (_) => pressUp(),
        child: Container(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: widget.duration,
            curve: Curves.easeOut,
            opacity: isPressed ? 0.6 : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}