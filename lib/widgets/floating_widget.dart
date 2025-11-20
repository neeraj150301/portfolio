import 'package:flutter/material.dart';

class FloatingWidget extends StatefulWidget {
  final Widget child;
  final double distance;
  final Duration duration;

  final double initialOffset;

  const FloatingWidget({
    super.key,
    required this.child,
    this.distance = 10.0,
    this.duration = const Duration(seconds: 3),
    this.initialOffset = 0.0,
  });

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(begin: -widget.distance, end: widget.distance)
        .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
        );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward(from: widget.initialOffset);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
