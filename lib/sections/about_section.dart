import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/responsive.dart';
import '../widgets/hover_effect.dart';
import '../widgets/floating_widget.dart';

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
                  const SizedBox(height: 16),
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
                  SizedBox(width: isMobile(context) ? 16 : 62),
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
      fontSize: isMobile(context) ? 14 : 22,
      color: Colors.white70,
    ),
  );

  Widget _skillsGrid(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: isMobile(context) ? 0 : 20.0),
    child: Wrap(
      spacing: isMobile(context) ? 10 : 30,
      runSpacing: isMobile(context) ? 10 : 30,
      children: const [
        _SkillChip("Flutter", FontAwesomeIcons.flutter, Colors.blue),
        _SkillChip("Git", FontAwesomeIcons.gitAlt, Colors.redAccent),
        _SkillChip("Dart", FontAwesomeIcons.dartLang, Colors.blueAccent),
        _SkillChip("Firebase", FontAwesomeIcons.fire, Colors.orange),
        _SkillChip("REST APIs", FontAwesomeIcons.server, Colors.green),
        _SkillChip("WebSocket", FontAwesomeIcons.connectdevelop, Colors.purple),
        _SkillChip("MongoDB", FontAwesomeIcons.database, Colors.greenAccent),
        _SkillChip("Riverpod", FontAwesomeIcons.layerGroup, Colors.blueGrey),
        _SkillChip("Bloc", FontAwesomeIcons.cubes, Colors.indigo),
        _SkillChip("Clean Architecture", FontAwesomeIcons.sitemap, Colors.teal),
      ],
    ),
  );
}

class _SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _SkillChip(this.label, this.icon, this.color);

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return FloatingWidget(
      distance: 5,
      // duration: Duration(milliseconds: 2000 + label.length * 100), // Staggered
      child: HoverEffect(
        scale: 1.1,
        lift: 4,
        child: Container(
          padding: isMobile(context)
              ? EdgeInsets.symmetric(vertical: 5, horizontal: 5)
              : EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.2),
                Colors.blueAccent.withOpacity(0.10),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile(context) ? 12 : 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
