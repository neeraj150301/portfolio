import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.12),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
            child: Responsive(
              mobile: Column(
                children: [
                  _aboutText(
                    context,
                  ).animate().fade(duration: 600.ms).slideY(begin: .2, end: 0),
                  const SizedBox(height: 32),
                  _skillsGrid(
                    context,
                  ).animate().fade(duration: 600.ms).slideY(begin: .2, end: 0),
                ],
              ),
              desktop: Column(
                children: [
                  _aboutText(
                    context,
                  ).animate().fade(duration: 600.ms).slideX(begin: -.2, end: 0),
                  SizedBox(width: isMobile(context) ? 32 : 62),
                  _skillsGrid(
                    context,
                  ).animate().fade(duration: 600.ms).slideX(begin: .2, end: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _aboutText(BuildContext context) => Text(
    "I am Neeraj Sharma — a Software Developer with 2+ years of experience building scalable mobile and web applications using Flutter.\n\n"
    "I specialize in clean architecture, performance-focused UI, and seamless backend integration using REST APIs, WebSockets, and Firebase. My work involves creating production-grade apps that are fast, reliable, and visually engaging.\n\n"
    "Currently, I work at Five Exceptions Software Solutions, where I developed a blockchain-based multi-chain wallet with NFC integration, app-level security, and encrypted transactions. Previously, at RR ISPAT (GPIL), I built store and inventory management systems, dashboards, and Angular/NestJS-based web applications.\n\n"
    "I love solving real-world problems through technology and building products that deliver smooth user experience and business value.\n\n",
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      height: 1.6,
      fontSize: isMobile(context) ? 12 : 22,
      color: Colors.white70,
    ),
  );

  Widget _skillsGrid(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: isMobile(context) ? 10 : 20.0),
    child: Wrap(
      spacing: isMobile(context) ? 10 : 30,
      runSpacing: isMobile(context) ? 10 : 30,
      children: const [
        _SkillChip("Flutter"),
        _SkillChip("Git"),
        _SkillChip("Dart"),
        _SkillChip("Firebase"),
        _SkillChip("REST APIs"),
        _SkillChip("WebSocket"),
        _SkillChip("MongoDB"),
        _SkillChip("Riverpod"),
        _SkillChip("Bloc"),
        _SkillChip("Clean Architecture"),
      ],
    ),
  );
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.withOpacity(0.28),
            Colors.blueAccent.withOpacity(0.10),
          ],
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isMobile(context) ? 12 : 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
