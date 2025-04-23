import 'package:ev_charge/core/backend_service.dart';
import 'package:ev_charge/providers/ev_providers.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_navbar.dart';

class EvPage extends ConsumerWidget {
  const EvPage({super.key, required this.id});

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
            ev.currentChargingPower != 0 ? Colors.green : Colors.red;

        return Scaffold(
          appBar: AppBar(
            title: const Text('EV details'),
            actions: [
              IconButton(
                onPressed: () async {
                  try {
                    await backendService.deleteEvById(id);
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
          ),
          body: Center(
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 8),
                Text(
                  ev.userSetName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 5, backgroundColor: indicatorColor),
                    const SizedBox(width: 8),
                    Text(
                      "${ev.currentChargingPower} kW",
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
                      height: 300,
                      width: 300,
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
                const Padding(padding: EdgeInsets.all(8)),
                ElevatedButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.dial,
                    );
                  },
                  child: const Text("Schedule charging"),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
