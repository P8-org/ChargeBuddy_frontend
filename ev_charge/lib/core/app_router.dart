import 'package:ev_charge/views/electricity_prices_page.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/homepage.dart';
import '../views/settings.dart';
import '../views/add_ev.dart';
import '../views/edit_ev.dart';
import '../views/ev_detailspage.dart';
import '../views/ev_schedulepage.dart';

Page _slideTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide in from the right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      var fadeAnimation = animation.drive(CurveTween(curve: Curves.easeIn));

      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(opacity: fadeAnimation, child: child),
      );
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(body: child, bottomNavigationBar: const BottomNavBar());
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: '/prices',
          builder: (BuildContext context, GoRouterState state) {
            return const ElectricityPricesPage();
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            return const Settings();
          },
        ),
        GoRoute(
          path: '/add_ev',
          builder: (BuildContext context, GoRouterState state) {
            return const AddEv();
          },
        ),
        GoRoute(
          path: '/edit_ev/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.parse(state.pathParameters["id"]!);
            return EVEdit(id: id);
          },
        ),
        GoRoute(
          path: '/ev/:id',
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return _slideTransition(EvSchedulePage(id: id));
          },
          routes: [
            GoRoute(
              path: 'schedule',
              pageBuilder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return _slideTransition(EvSchedulePage(id: id));
              },
            ),
            GoRoute(
              path: 'details',
              pageBuilder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return _slideTransition(EvDetailsPage(id: id));
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
