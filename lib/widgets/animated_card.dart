// import 'package:flutter/material.dart';

// class AnimatedCard extends StatefulWidget {
//   final Widget child;
//   final VoidCallback? onTap;
//   const AnimatedCard({required this.child, this.onTap, super.key});

//   @override
//   State<AnimatedCard> createState() => _AnimatedCardState();
// }

// class _AnimatedCardState extends State<AnimatedCard>
//     with SingleTickerProviderStateMixin {
//   double _scale = 1.0;
//   late final AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//   }

//   void _onEnter(bool hover) {
//     setState(() => _scale = hover ? 1.03 : 1.0);
//     if (hover)
//       _controller.forward();
//     else
//       _controller.reverse();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => _onEnter(true),
//       onExit: (_) => _onEnter(false),
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedScale(
//           duration: const Duration(milliseconds: 200),
//           scale: _scale,
//           child: Material(
//             color: const Color(0xFF071228),
//             elevation: 6,
//             borderRadius: BorderRadius.circular(16),
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               child: widget.child,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
