import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'widgets/top_navigation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'widgets/particle_background.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neeraj Sharma | Portfolio',
      theme: base.copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B1120),
        textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
        colorScheme: base.colorScheme.copyWith(
          primary: Colors.blueAccent,
          secondary: Colors.lightBlueAccent,
        ),
      ),
      home: SafeArea(child: const PortfolioHomePage()),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ItemScrollController _scrollController = ItemScrollController();
  final ItemPositionsListener _positionsListener =
      ItemPositionsListener.create();

  bool _showAppBar = true;
  double _lastScrollPosition = 0;

  late final VoidCallback _positionsListenerCallback;
  void scrollToSection(int index) => _scrollController.scrollTo(
    index: index,
    duration: const Duration(milliseconds: 600),
  );

  @override
  void initState() {
    super.initState();

    _positionsListenerCallback = () {
      final positions = _positionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        // Choose the item closest to top (smallest itemLeadingEdge)
        final first = positions
            .where((p) => p.itemLeadingEdge <= 1)
            .reduce((a, b) => a.itemLeadingEdge < b.itemLeadingEdge ? a : b);

        final currentPos = first.itemLeadingEdge;

        // If currentPos decreases compared to last (moves up the screen), user is scrolling DOWN
        if (currentPos < _lastScrollPosition && currentPos < 0.95) {
          if (_showAppBar) setState(() => _showAppBar = false);
        } else {
          if (!_showAppBar) setState(() => _showAppBar = true);
        }

        _lastScrollPosition = currentPos;
      }
    };

    _positionsListener.itemPositions.addListener(_positionsListenerCallback);
  }

  @override
  void dispose() {
    // remove listener to avoid leaks
    _positionsListener.itemPositions.removeListener(_positionsListenerCallback);
    super.dispose();
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;
  @override
  Widget build(BuildContext context) {
    final animatedNav = AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: _showAppBar ? Offset.zero : const Offset(0, -1),
      child: AnimatedOpacity(
        opacity: _showAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: TopNavigation(onNavClick: scrollToSection),
      ),
    );
    return Scaffold(
      floatingActionButton: _animatedResumeButton(),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: animatedNav,
      ),
      drawer: isMobile(context) ? _buildDrawer(context) : null,

      body: Stack(
        children: [
          const Positioned.fill(child: ParticleBackground()),
          ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemPositionsListener: _positionsListener,
            itemCount: 5, // Increased for footer
            itemBuilder: (_, index) {
              if (index == 4) {
                return const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      "© 2025 Neeraj Sharma. Built with Flutter 💙",
                      style: TextStyle(color: Colors.white24, fontSize: 12),
                    ),
                  ),
                );
              }
              return [
                HomeSection(onNavClick: scrollToSection),
                const AboutSection(),
                const ProjectsSection(),
                const ContactSection(),
              ][index];
            },
          ),
        ],
      ),
    );
  }

  Widget _animatedResumeButton() {
    return GestureDetector(
      onTap: _downloadResume,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.9, end: 1.1),
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
        builder: (context, value, _) {
          return Transform.translate(
            offset: Offset(0, -4 * value), // create little jumping effect
            child: Transform.scale(
              scale: value,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                // child: CircleAvatar(
                //   radius: 34,
                //   backgroundColor: Colors.blueAccent,
                child: Lottie.asset(
                  'assets/animations/mail.json',
                  repeat: true,
                  animate: true,
                  height: 80,
                  // ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ✅ Resume download handler
  void _downloadResume() async {
    final url = Uri.parse(
      "https://raw.githubusercontent.com/neeraj150301/portfolio/main/assets/resume/Neeraj_Sharma_Resume.pdf",
    );

    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            color: Colors.white.withOpacity(0.06),
            child: ListView(
              padding: const EdgeInsets.only(top: 80),
              children: [
                _drawerTile(context, "Home", 0),
                _drawerTile(context, "About", 1),
                _drawerTile(context, "Projects", 2),
                _drawerTile(context, "Contact", 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerTile(BuildContext context, String title, int index) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context); // closes drawer
        scrollToSection(index); // scrolls to section
      },
    );
  }
}
