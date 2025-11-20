import 'package:flutter/material.dart';
import 'dart:math';
import '../constants/app_colors.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (_particles.isEmpty) {
      for (int i = 0; i < 50; i++) {
        _particles.add(
          Particle(
            position: Offset(
              _random.nextDouble() * size.width,
              _random.nextDouble() * size.height,
            ),
            velocity: Offset(
              (_random.nextDouble() - 0.5) * 0.5,
              (_random.nextDouble() - 0.5) * 0.5,
            ),
            radius: _random.nextDouble() * 3 + 1,
            color: [
              AppColors.accentBlue,
              AppColors.accentRed,
              AppColors.accentYellow,
              AppColors.accentGreen,
            ][_random.nextInt(4)].withOpacity(0.3),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _initParticles(Size(constraints.maxWidth, constraints.maxHeight));
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            _updateParticles(Size(constraints.maxWidth, constraints.maxHeight));
            return CustomPaint(
              painter: ParticlePainter(_particles),
              size: Size(constraints.maxWidth, constraints.maxHeight),
            );
          },
        );
      },
    );
  }

  void _updateParticles(Size size) {
    for (var particle in _particles) {
      particle.position += particle.velocity;

      if (particle.position.dx < 0 || particle.position.dx > size.width) {
        particle.velocity = Offset(-particle.velocity.dx, particle.velocity.dy);
      }
      if (particle.position.dy < 0 || particle.position.dy > size.height) {
        particle.velocity = Offset(particle.velocity.dx, -particle.velocity.dy);
      }
    }
  }
}

class Particle {
  Offset position;
  Offset velocity;
  double radius;
  Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(particle.position, particle.radius, paint);
    }

    // Draw connections
    final paintLine = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final distance =
            (particles[i].position - particles[j].position).distance;
        if (distance < 100) {
          canvas.drawLine(
            particles[i].position,
            particles[j].position,
            paintLine,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
