import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
                  _skillsGrid()
                      .animate()
                      .fade(duration: 600.ms)
                      .slideY(begin: .2, end: 0),
                ],
              ),
              desktop: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _aboutText(context)
                        .animate()
                        .fade(duration: 600.ms)
                        .slideX(begin: -.2, end: 0),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 2,
                    child: _skillsGrid()
                        .animate()
                        .fade(duration: 600.ms)
                        .slideX(begin: .2, end: 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _aboutText(BuildContext context) => Text(
    "I am Neeraj Sharma — a Software Developer focused on building cross-platform apps using Flutter. I build clean-architecture apps, integrate backends with REST & WebSocket, and care strongly about performance and user experience.\n\nCurrently working at Five Exceptions Software Solutions where I developed multi-chain wallet features, NFC integrations and strong app-level security. Previously worked on store management apps, dashboards, and Angular/NestJS web apps.",
    style: Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 22),
  );

  Widget _skillsGrid() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: Wrap(
      spacing: 30,
      runSpacing: 30,
      children: const [
        _SkillChip("Flutter"),
        _SkillChip("Dart"),
        _SkillChip("Firebase"),
        _SkillChip("REST APIs"),
        _SkillChip("WebSocket"),
        _SkillChip("MongoDB"),
        _SkillChip("Riverpod"),
        _SkillChip("Git"),
        _SkillChip("Clean Architecture"),
      ],
    ),
  );
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

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
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
