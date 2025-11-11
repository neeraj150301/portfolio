import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/responsive.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Chatty\n(Realtime Chat App)',
        'github': 'https://github.com/neeraj150301/sampark',
        'desc':
            'Flutter + Firebase — Auth, Messaging, Push Notifications, Dark Mode',
        'images': [
          'assets/chatty/1000093543.jpg',
          'assets/chatty/1000093544.jpg',
          'assets/chatty/1000093545.jpg',
          'assets/chatty/1000093546.jpg',
        ],
        'desc2':
            'A real-time messaging application built with Flutter and Firebase, featuring secure authentication, instant messaging, image sharing, dark mode support, push notifications with deep linking to chats, and comprehensive profile management.',
      },
      {
        'title': 'VNR Geolocation',
        'github': 'https://github.com/neeraj150301/geolocation',
        'images': [
          'assets/geoLocation/1000093539.jpg',
          'assets/geoLocation/1000093541.jpg',
          'assets/geoLocation/1000093540.jpg',
          'assets/geoLocation/1000093542.jpg',
        ],
        'desc': 'Background location tracking, last 5 locations, notifications',
        'desc2':
            'A geolocation-based application that tracks user locations every 5 minutes, displays the last five locations on their profile, sends notifications if a user moves more than 20 meters, and provides live location tracking with seamless session and profile management.',
      },
      {
        'title': 'Store Management App',
        'github': 'https://github.com/neeraj150301/cart_management_system',
        'images': [
          'assets/stock_management/1000093532.jpg',
          'assets/stock_management/1000093533.jpg',
          'assets/stock_management/1000093534.jpg',
          'assets/stock_management/1000093535.jpg',
        ],
        'desc': 'Inventory, QR code workflows, Excel import/export',
        'desc2':
            'A cross-platform application for managing inventory, allowing bulk item uploads via Excel, QR code generation, scanning for item requests and issuance, and exporting stock and issued item reports to Excel, with a user-friendly interface for web and mobile.',
      },
      {
        'title': 'Stock Quote App',
        'github': 'https://github.com/neeraj150301/stock_quote',
        'images': [
          'assets/stock/1000093547.jpg',
          'assets/stock/1000093549.jpg',
          'assets/stock/1000093548.jpg',
          'assets/stock/1000093550.jpg',
        ],
        'desc': 'Realtime stock quotes, watchlist',
        'desc2':
            'Developed a Flutter-based mobile application that displays real-time stock quotes using APIs like Alpha Vantage. Implemented features such as search, watchlist, along with state management (Provider) for efficient data handling. Focused on clean architecture, error handling, and responsive UI with performance optimization and testing.',
      },
      {
        'title': 'AI Chatbot',
        'github':
            'https://github.com/neeraj150301/flutter_ai_chatbot/tree/main/flutter_ai/my_app',
        'images': [
          'assets/ai_chatbot/Screenshot_20251111_124436.jpg',
          'assets/ai_chatbot/Screenshot_20251111_124447.jpg',
          'assets/ai_chatbot/Screenshot_20251111_124522.jpg',
          'assets/ai_chatbot/Screenshot_20251111_124536.jpg',
        ],
        'desc':
            'AI chatbot powered by Google Gemini — text & image understanding',
        'desc2':
            'An intelligent AI chatbot built using Flutter and Google Gemini API. The app allows users to chat with AI, ask questions, and even upload images to get context-based answers. Features include: AI conversation, image recognition, chat history, material UI design, error handling.',
      },
      {
        'title': 'Pooja App',
        'github': 'https://github.com/neeraj150301/puja',
        'images': [
          'assets/pooja/Screenshot_20251111_130355.jpg',
          'assets/pooja/Screenshot_20251111_130402.jpg',
          'assets/pooja/Screenshot_20251111_130419.jpg',
          'assets/pooja/Screenshot_20251111_130430.jpg',
          'assets/pooja/Screenshot_20251111_130440.jpg',
        ],
        'desc': 'Search Hindu Poojas with steps, mantras & bilingual audio',
        'desc2':
            'A devotional Pooja guide app built using Flutter, where users can search any Pooja and get detailed steps, required samagri list, and mantras. The app supports dual languages (Hindi & English) with voice narration. Users can switch language anytime from the home screen, and the mantras + audio adapt automatically.',
      },
    ];
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Projects",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isDesktop ? 56 : 40,
            ),
          ),
          const SizedBox(height: 45),

          /// ✅ Responsive layout
          Responsive(
            mobile: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: projects
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _glassCard(context, p),
                    ),
                  )
                  .toList(),
            ),
            desktop: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: projects.map((p) => _glassCard(context, p)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard(BuildContext context, Map p) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          if (!isDesktop) _openProjectModal(context, p); // ✅ Only mobile
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          width: isDesktop ? 700 : double.infinity,
          height: isDesktop ? 450 : null,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.12),
                Colors.white.withOpacity(0.05),
              ],
            ),
          ),
          child: isDesktop
              ? _desktopExpandedCard(context, p) // ✅ NEW UI on Desktop
              : _mobileCard(p),
        ),
      ),
    );
  }

  Widget _desktopExpandedCard(BuildContext context, Map p) {
    return Row(
      children: [
        // IMAGES CAROUSEL LEFT
        Expanded(
          flex: 2,
          child: CarouselSlider(
            items: (p['images'] as List<String>).map((img) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(img, fit: BoxFit.contain),
              );
            }).toList(),
            options: CarouselOptions(
              height: 220,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              autoPlay: true,
            ),
          ),
        ),

        const SizedBox(width: 24),

        // TEXT RIGHT
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p['title'],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                p['desc2'],
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: () async {
                  final url = Uri.parse(p['github']);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(Icons.open_in_new, color: Colors.white),
                label: const Text(
                  "View GitHub",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mobileCard(Map p) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        p['title'],
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 8),
      Text(p['desc'], style: const TextStyle(color: Colors.white70)),
      const SizedBox(height: 12),
      const Text(
        "Tap to view details →",
        style: TextStyle(color: Colors.blueAccent),
      ),
    ],
  );

  void _openProjectModal(BuildContext context, Map p) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        int activeIndex = 0; // ✅ local index tracking for dots

        return StatefulBuilder(
          builder: (context, setState) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 80,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white.withOpacity(0.25)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.18),
                        Colors.white.withOpacity(0.06),
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// ✅ Title with glow effect
                        Text(
                          p['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 8, color: Colors.blueAccent),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        /// ✅ Carousel with shadow
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CarouselSlider(
                            items: (p['images'] as List<String>).map((img) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(img),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            }).toList(),
                            // carouselController: controller,
                            options: CarouselOptions(
                              height: 300,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              viewportFraction: 0.9,
                              autoPlayInterval: const Duration(seconds: 3),
                              onPageChanged: (index, reason) {
                                setState(() => activeIndex = index);
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// ✅ Animated dots indicator (fixed)
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              (p['images'] as List<String>).length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                height: activeIndex == index ? 10 : 8,
                                width: activeIndex == index ? 24 : 8,
                                decoration: BoxDecoration(
                                  color: activeIndex == index
                                      ? Colors.blueAccent
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        /// Description with readable soft color
                        Text(
                          p['desc2'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// ✅ Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                final url = Uri.parse(p['github']);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              icon: const Icon(
                                Icons.open_in_new,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "View GitHub",
                                style: TextStyle(color: Colors.white),
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
          ),
        );
      },
    );
  }
}
