import 'package:flutter/material.dart';

class TopNavigation extends StatelessWidget implements PreferredSizeWidget {
  final Function(int) onNavClick;
  const TopNavigation({required this.onNavClick, super.key});

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.2),
      elevation: 0,
      toolbarHeight: 70,

      centerTitle: true,
      title: isMobile(context)
          ? const Text(
              "Neeraj Sharma",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _navButton("Home", () => onNavClick(0)),
                _navButton("About", () => onNavClick(1)),
                _navButton("Projects", () => onNavClick(2)),
                _navButton("Contact", () => onNavClick(3)),
              ],
            ),
      leading: isMobile(context)
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, size: 28),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
    );
  }

  Widget _navButton(String label, VoidCallback onTap) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: InkWell(
      onTap: onTap,
      hoverColor: Colors.blueAccent.withOpacity(0.1),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
