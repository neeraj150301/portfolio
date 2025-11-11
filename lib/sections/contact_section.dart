import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.12),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Let’s Connect ✨",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    "Have an opportunity or idea? I'd be happy to collaborate!",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),

                  const SizedBox(height: 30),

                  // ✅ Contact Info Row
                  Column(
                    children: const [
                      _ContactItem(
                        icon: Icons.email,
                        text: "neerajs150301@gmail.com",
                      ),
                      SizedBox(height: 12),
                      _ContactItem(icon: Icons.phone, text: "+91 6261197020"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ✅ Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6,
                    children: [
                      _iconButton1(
                        "assets/linkedin-removebg-preview.png",
                        _openLinkedIn,
                      ),
                      _iconButton1("assets/git-white.png", _openGithub),
                    ],
                  ),
                ],
              ).animate().fade(duration: 600.ms).slideY(begin: .2, end: 0),
            ),
          ),
        ),
      ),
    );
  }

  // 🔘 Filled CTA button
  static Widget _iconButton1(String asset, VoidCallback onTap) => SizedBox(
    height: 35,
    width: 40,
    child: Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: IconButton(
        onPressed: onTap,
        icon: Image.asset(asset),
        style: IconButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(2),

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    ),
  );

  static void _openLinkedIn() async {
    final url = Uri.parse("https://linkedin.com/in/neeraj-sharma-66a686259");
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  static void _openGithub() async {
    final url = Uri.parse("https://github.com/neeraj150301");
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}

// ✅ Reusable contact info tile
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
