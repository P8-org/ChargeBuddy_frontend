import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static const List<NavItem> navItems = [
    NavItem(
      route: '/',
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavItem(
      route: '/prices',
      label: 'Electricity prices',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart,
    ),
    NavItem(
      route: '/settings',
      label: 'Settings',
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
    ),
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

    return NavigationBar(
      destinations:
          navItems
              .map(
                (navItem) => NavigationDestination(
                  icon: Icon(navItem.icon),
                  label: navItem.label,
                  selectedIcon: Icon(navItem.selectedIcon),
                ),
              )
              .toList(),
      onDestinationSelected: (index) => context.go(navItems[index].route),
      selectedIndex: selectedIndex,
    );
  }
}

class NavItem {
  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const NavItem({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
