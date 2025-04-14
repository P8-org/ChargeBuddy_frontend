import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  static const List<NavItem> navItems = [
    NavItem(route: '/', label: 'Home', icon: Icons.home),
    NavItem(route: '/settings', label: 'Settings', icon: Icons.settings),
  ];

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (int i = 0; i < navItems.length; i++) {
      if (location == navItems[i].route ||
          location.startsWith('${navItems[i].route}/')) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => context.go(navItems[index].route),
      items:
          navItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            );
          }).toList(),
    );
  }
}

class NavItem {
  final String route;
  final String label;
  final IconData icon;

  const NavItem({required this.route, required this.label, required this.icon});
}
