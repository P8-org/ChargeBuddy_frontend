import 'package:ev_charge/providers/db_refresh_provider.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/ev_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_charge/database/db_manager.dart';

import '../main.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(databaseAutoUpdaterProvider);
    final evsState = ref.watch(allUserEvsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
      ),
      body: evsState.when(
        data: (evs) {
          if (evs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No cars in db"),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () => context.push("/add_ev"),
                    label: const Text("Add EV"),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              final db = ref.read(dbProvider);
              await DbManager.updateDatabase(db);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Database refreshed.')),
              );
            },

            child: ListView.builder(
              itemCount: evs.length,
              itemBuilder: (context, index) {
                if (index + 1 == evs.length) {
                  return Column(
                    children: [
                      EvCard(ev: evs[index]),
                      ElevatedButton.icon(
                        onPressed: () => context.push("/add_ev"),
                        label: Text("Add EV"),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  );
                }
                return EvCard(ev: evs[index]);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stackTrace) {
          debugPrintStack(stackTrace: stackTrace);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error: $e"),
                ElevatedButton(
                  onPressed: () => ref.refresh(allUserEvsProvider),
                  child: const Text("Try again"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
