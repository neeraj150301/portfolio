import 'package:flutter/material.dart';

class HoverEffect extends StatefulWidget {
  final Widget child;
  final double scale;
  final double lift;

  const HoverEffect({
    super.key,
    required this.child,
    this.scale = 1.05,
    this.lift = 4.0,
  });

  @override
  State<HoverEffect> createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuad,
        transform: Matrix4.identity()
          ..scale(_isHovered ? widget.scale : 1.0)
          ..translate(0.0, _isHovered ? -widget.lift : 0.0),
        child: widget.child,
      ),
    );
  }
}
