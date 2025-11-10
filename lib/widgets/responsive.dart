import 'package:flutter/material.dart';

const double _desktopBreakpoint = 1000;
const double _tabletBreakpoint = 700;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    required this.mobile,
    this.tablet,
    required this.desktop,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= _desktopBreakpoint) return desktop;
    if (w >= _tabletBreakpoint) return tablet ?? desktop;
    return mobile;
  }
}
