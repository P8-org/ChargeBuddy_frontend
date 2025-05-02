import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:ev_charge/widgets/charging_curve_widget.dart';
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

        final indicatorColor =
            ev.state == "charging"
                ? Colors.green
                : ev.state == "idle"
                ? Colors.amber
                : Colors.red;

        return Scaffold(
          appBar: AppBar(
            title: const Text('EV Details'),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    await backendService.deleteEvById(id);
                    if (!context.mounted) return;
                    context.pop();
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
                Text(
                  ev.userSetName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 5, backgroundColor: indicatorColor),
                    const SizedBox(width: 8),
                    Text(
                      ev.currentChargingPower != 0
                          ? "${ev.state[0].toUpperCase()}${ev.state.substring(1)} ${ev.currentChargingPower} kW"
                          : "${ev.state[0].toUpperCase()}${ev.state.substring(1)}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TweenAnimationBuilder(
                  tween: Tween(
                    begin: ev.currentCharge / ev.carModel.batteryCapacity,
                    end: ev.currentCharge / ev.carModel.batteryCapacity,
                  ),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return BatteryLevelCircle(
                      value: value,
                      limitValue: ev.constraint.targetPercentage,
                      height: 250,
                      width: 250,
                      strokeWidth: 30,
                      center: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                (value * 100).toStringAsFixed(1),
                                style: const TextStyle(fontSize: 48),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 84),
                                child: Text(
                                  "%",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
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
