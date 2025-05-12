import 'package:ev_charge/core/models.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:ev_charge/widgets/battery_circle.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EVInfoCard extends ConsumerWidget {
  final UserEV ev;

  const EVInfoCard({super.key, required this.ev});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateColor =
        ev.state == "charging"
            ? Colors.green
            : ev.state == "idle"
            ? Colors.amber
            : Colors.red;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.circular(20),
        baseColor: Theme.of(context).colorScheme.surface,
        expandedColor: Theme.of(context).colorScheme.surfaceContainer,
        shadowColor: Theme.of(context).colorScheme.shadow,
        leading: Icon(
          Icons.electric_car,
          color: Theme.of(context).colorScheme.primary,
          size: 35,
        ),
        title: Text(
          ev.userSetName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        subtitle: Text(
          '${ev.carModel.modelName} \nCurrent Charge: ${(ev.currentCharge / ev.carModel.batteryCapacity * 100).toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 20),
        ),
        children: [
          const Divider(thickness: 1.0, height: 1.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Battery Capacity: ${ev.carModel.batteryCapacity.toStringAsFixed(1)} kWh',
                ),
                Text(
                  'Max Charging Power: ${ev.carModel.maxChargingPower.toStringAsFixed(1)} kW',
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Charging State:'),
                    const SizedBox(width: 8),
                    CircleAvatar(radius: 5, backgroundColor: stateColor),
                    const SizedBox(width: 8),
                    Text(ev.state),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push("/edit_ev/${ev.id}"),
                  label: Text("Edit EV"),
                  icon: Icon(Icons.edit),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TweenAnimationBuilder(
                    tween: Tween(
                      begin: ev.currentCharge / ev.carModel.batteryCapacity,
                      end: ev.currentCharge / ev.carModel.batteryCapacity,
                    ),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return BatteryLevelCircle(
                        value: value,
                        limitValue: 200,
                        height: 200,
                        width: 200,
                        strokeWidth: 20,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
