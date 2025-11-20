import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/floating_widget.dart';
import '../constants/app_colors.dart';

class HomeSection extends StatelessWidget {
  final Function(int) onNavClick;
  const HomeSection({required this.onNavClick, super.key});

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              "https://volpis.com/wp-content/uploads/2024/08/Flutter-vs-Native-app-dev.png",
              fit: BoxFit.cover,
            ),
          ),
          // ParticleBackground is global in main.dart
          Center(
            child: FloatingWidget(
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    padding: const EdgeInsets.all(35),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isMobile(context))
                          Text(
                                "Neeraj Sharma",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                              .animate()
                              .fade(duration: 600.ms)
                              .slideY(begin: -0.4, end: 0),
                        Text(
                              "Flutter Developer",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                            .animate()
                            .fade(duration: 600.ms)
                            .slideY(begin: -0.4, end: 0),

                        const SizedBox(height: 10),
                        Text(
                          "I build secure, scalable and high-performance applications using Flutter.\nTurning ideas into production-ready apps with clean architecture, realtime features, and stunning UI/UX.",
                          style: TextStyle(
                            fontSize: isMobile(context) ? 14 : 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fade(duration: 600.ms),

                        const SizedBox(height: 25),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          children: [
                            _glowButton(
                              "View Projects",
                              () => onNavClick(2),
                              context,
                            ),

                            _glowButton(
                              "Contact",
                              () => launchUrl(
                                Uri.parse("mailto:neerajs150301@gmail.com"),
                              ),
                              context,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glowButton(String text, VoidCallback action, BuildContext context) {
    // return GestureDetector(
    //   onTap: action,

    //   // child: FloatingWidget(
    //   //   duration: const Duration(seconds: 4),
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(30),
    //       border: Border.all(color: AppColors.accentBlue),
    //       color: AppColors.accentBlue.withOpacity(0.1),
    //     ),
    //     child: Text(
    //       text,
    //       style: TextStyle(
    //         color: AppColors.accentBlue,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    //   // ),
    // );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: action,
        child: Container(
          padding: isMobile(context)
              ? EdgeInsets.symmetric(horizontal: 20, vertical: 10)
              : EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.accentBlue),
            color: AppColors.accentBlue.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentBlue.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: isMobile(context) ? 10 : 16,
            ),
          ),
        ),
      ),
    );
  }
}
