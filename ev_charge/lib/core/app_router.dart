import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/homepage.dart';
import '../views/infopage.dart';
import '../views/settings.dart';

// GoRouter configuration
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
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
      ],
    ),
  ],
);