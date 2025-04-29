import 'package:ev_charge/views/electricity_prices_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/homepage.dart';
import '../views/settings.dart';
import '../views/add_ev.dart';
import '../views/edit_ev.dart';
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
          path: 'edit_ev/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.parse(state.pathParameters["id"]!);
            return EVEdit(id: id);
          }
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
                return EvSchedulePage(id: id);
              },
            ),
            GoRoute(
              path: 'details',
              builder: (context, state) {
                final id = int.parse(state.pathParameters['id']!);
                return EvDetailsPage(id: id);
              },
            ),
          ],
        ),
        GoRoute(
          path: "prices",
          builder: (context, state) {
            return ElectricityPricesPage();
          },
        ),
      ],
    ),
  ],
);
