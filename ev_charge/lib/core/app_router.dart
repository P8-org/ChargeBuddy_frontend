import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/homepage.dart';
import '../views/infopage.dart';
import '../views/settings.dart';
import '../views/ev_detailspage.dart';
import '../views/ev_schedulepage.dart';

// GoRouter configuration
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'infopage',
          builder: (BuildContext context, GoRouterState state) {
            return const InfoPage();
          },
        ),
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const Settings();
          },
        ),
        GoRoute(
          path: 'ev/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return EvSchedulePage(id: id);
          },
          routes: [
            GoRoute(
              path: 'schedule',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return EvSchedulePage(id: id); // this is your schedule screen
              },
            ),
            GoRoute(
              path: 'details',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return EvDetailsPage(id: id); // this is your details screen
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
