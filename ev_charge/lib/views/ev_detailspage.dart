import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/charging_curve_widget.dart';
import 'package:ev_charge/widgets/ev_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_navbar.dart';

class EvDetailsPage extends ConsumerWidget {
  const EvDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ev = ref.watch(singleEvDetailProvider(id));
    final backendService = BackendService();
    return ev.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (e, _) => Scaffold(
            appBar: AppBar(title: const Text("EV details")),
            body: Center(child: Text("Error: $e")),
          ),
      data: (ev) {
        if (ev == null) {
          return const Scaffold(body: Center(child: Text("EV not found")));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('EV Details'),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    await backendService.deleteEvById(id);
                    if (!context.mounted) return;
                    context.go('/home');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to delete: $e")),
                    );
                  }
                },
                icon: const Icon(Icons.delete_forever_rounded),
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          body: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: EVInfoCard(id: ev.id),
                ),
                SizedBox(height: 16),
                SizedBox(child: ChargingCurve(ev: ev)),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
