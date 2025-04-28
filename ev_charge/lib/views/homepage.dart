// Updated homepage.dart using Riverpod and DAO stream
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/bottom_navbar.dart';
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
    final evsState = ref.watch(allUserEvsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profile',
            onPressed: () {
              context.go('/settings');
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
                    onPressed: () => context.go("/add_car"),
                    label: const Text("Add car"),
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
                        onPressed: () => context.go("/add_ev"),
                        label: Text("Add EV"),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  );
                }
                return EvCard(ev: evs[index]);
              },),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, _) => Center(
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
            ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
