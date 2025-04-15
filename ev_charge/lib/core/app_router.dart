import 'package:ev_charge/views/ev_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/homepage.dart';
import '../views/infopage.dart';
import '../views/settings.dart';
import '../views/add_ev.dart';

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
          path: 'add_ev',
          builder: (BuildContext context, GoRouterState state) {
            return const AddEv();
          }
        ),
        GoRoute(
          path: 'car/:id',
          builder: (context, state) {
            var id = int.parse(state.pathParameters["id"]!);
            return EvPage(id: id);
          },
        ),
      ],
    ),
  ],
);
