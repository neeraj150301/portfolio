import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

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
          Positioned.fill(
            child:
                // CachedNetworkImage(
                //   width: double.infinity,
                //   height: double.infinity,
                //   imageUrl:
                //       "https://volpis.com/wp-content/uploads/2024/08/Flutter-vs-Native-app-dev.png",
                //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                //       CircularProgressIndicator(
                //         value: downloadProgress.progress,
                //       ),
                //   errorWidget: (context, url, error) => Icon(Icons.error),
                // ).animate().blur(
                //   begin: Offset(10, 10),
                //   end: Offset(0, 0),
                //   duration: 1200.ms,
                // ),
                // Image.asset(
                //   "assets/background.jpg",
                //   fit: BoxFit.cover,
                // ).animate().blur(
                //   begin: Offset(10, 10),
                //   end: Offset(0, 0),
                //   duration: 1200.ms,
                // ),
                Image.network(
                  "https://volpis.com/wp-content/uploads/2024/08/Flutter-vs-Native-app-dev.png",
                  fit: BoxFit.cover,
                ).animate().blur(
                  begin: Offset(10, 10),
                  end: Offset(0, 0),
                  duration: 1200.ms,
                ),
          ),

          Center(
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
                          _glowButton("View Projects", () => onNavClick(2)),
                          _glowButton(
                            "Contact",
                            () => launchUrl(
                              Uri.parse("mailto:neerajs150301@gmail.com"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glowButton(String text, VoidCallback action) => ElevatedButton(
    onPressed: action,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ).copyWith(elevation: MaterialStateProperty.all(12)),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    ),
  );
}
